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
    @Published var values: [String?] = [nil, nil, nil, nil] // 배열로 변경
    @Published var totalCalorie: String? = nil
    func readValue(index: Int) { // 쓰는거 아니고 수정할 수 있음 수정함
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
    
    func observeTotalCalorie() {
        ref.child("foods").child("총_칼로리").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.totalCalorie = newValue
            }
        }
    }
}
