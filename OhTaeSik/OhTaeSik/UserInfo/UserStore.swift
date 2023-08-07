//
//  UserStore.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/04.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserStore: ObservableObject {
    @Published var users: [User] = []
    @Published var changeCount: Int = 0
    
    let ref: DatabaseReference? = Database.database().reference()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func listenToRealtimeDatabase() {
        
        guard let databasePath = ref?.child("users") else {
            return
        }
        
        databasePath
            .observe(.childAdded) { [weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else {
                    return
                }
                do {
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(User.self, from: userData)
                    self.users.append(user)
                } catch {
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childChanged){[weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(User.self, from: userData)
                    
                    var index = 0
                    for userItem in self.users {
                        if (user.id == userItem.id){
                            break
                        }else{
                            index += 1
                        }
                    }
                    self.users[index] = user
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.childRemoved){[weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(User.self, from: userData)
                    for (index, userItem) in self.users.enumerated() where user.id == userItem.id {
                        self.users.remove(at: index)
                    }
                } catch{
                    print("an error occurred", error)
                }
            }
        
        databasePath
            .observe(.value){[weak self] snapshot in
                guard
                    let self = self
                else {
                    return
                }
                self.changeCount += 1
            }
    }
    
    func stopListening() {
            ref?.removeAllObservers()
        }
        
    func addNewUser(user: User) {
        self.ref?.child("users").child("\(user.id)").setValue([
            "id": user.id,
            "name": user.name,
            "height": user.height,
            "weight": user.weight,
            "birth": user.birth,
            "gender": user.gender,
            "calorie": user.calorie
        ])
    }
        
    func deleteUser(key: String) {
        ref?.child("users/\(key)").removeValue()
    }
        
    func editUser(user: User) {
        let updates: [String : Any] = [
            "id": user.id,
            "name": user.name,
            "height": user.height,
            "weight": user.weight,
            "birth": user.birth,
            "gender": user.gender,
            "calorie": user.calorie
        ]
        
        let childUpdates = ["users/\(user.id)": updates]
        for (index, userItem) in users.enumerated() where userItem.id == user.id {
            users[index] = user
        }
        self.ref?.updateChildValues(childUpdates)
        
    }
}

