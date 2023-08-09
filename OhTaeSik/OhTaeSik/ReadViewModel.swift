//
//  ReadViewModel.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/08/09.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ReadViewModel: ObservableObject {
    var ref = Database.database().reference()
    @Published var values: [String?] = ["", "", "", ""] // 배열로 변경

    func readValue(index: Int) {
        ref.child("foods").child("\(index)").observeSingleEvent(of: .value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.values[index] = newValue
            }
        }
    }
    
    func observeDataChange(tag: String, index: Int) {
        ref.child("foods").child(tag).child("식사_총_칼로리").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.values[index] = newValue
            }
        }
    }
}
