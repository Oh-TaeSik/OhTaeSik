//
//  UserReadViewModel.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/10.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserReadViewModel: ObservableObject {
    var ref = Database.database().reference()
    @Published var user: User = User(id: "", name: "", weight: "", height: "", birth: "", gender: 0, calorie: 0)
    
    func observeNameData(uid: String) {
        ref.child("users").child(uid).child("name").observe(.value) { snapshot in
            if let name = snapshot.value as? String {
                self.user.name = name
            }
        }
    }
    
    func observeHeightData(uid: String) {
        ref.child("users").child(uid).child("height").observe(.value) { snapshot in
            if let height = snapshot.value as? String {
                self.user.height = height
            }
        }
    }
    
    func observeWeightData(uid: String) {
        ref.child("users").child(uid).child("weight").observe(.value) { snapshot in
            if let weight = snapshot.value as? String {
                self.user.weight = weight
            }
        }
    }
    
    func observeCalorieData(uid: String) {
        ref.child("users").child(uid).child("calorie").observe(.value) { snapshot in
            if let calorie = snapshot.value as? Double {
                self.user.calorie = calorie
            }
        }
    }
}
