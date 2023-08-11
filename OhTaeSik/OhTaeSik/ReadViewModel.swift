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
    let fommaterDate = DateFormatter()
    let monthDate = DateFormatter()
    var date = Date()
    
    var ref = Database.database().reference()
    @Published var values: [String?] = [nil, nil, nil, nil] // 배열로 변경
    @Published var totalNutrients: [Double] = [0.0, 0.0, 0.0]
    @Published var foodsValues: [String?] = [nil, nil, nil, nil, nil]
    @Published var foods: [FoodRead] = []
    @Published var goals: [FirebaseIsGoal] = []
    @Published var totalCalorie: String? = nil
    
    func readValue(index: Int) { // 쓰는거 아니고 수정할 수 있음 수정함
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child("\(index)").observeSingleEvent(of: .value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.values[index] = newValue
            }
        }
    }
    func observeDataChange(tag: String, index: Int) {
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child(tag).child("식사_총_칼로리").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.values[index] = newValue
            }
        }
    }
    
    func observeTotalCalorie() {
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child("총_칼로리").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.totalCalorie = Double(newValue)!
            }
        }
    }
    func observeTotalNutrients() {
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child("총_탄수화물").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.totalNutrients[0] = Double(newValue)! * 4
            }
        }
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child("총_단백질").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.totalNutrients[1] = Double(newValue)! * 4
            }
        }
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child("총_지방").observe(.value) { snapshot in
            if let newValue = snapshot.value as? String {
                self.totalNutrients[2] = Double(newValue)! * 9
            }
        }
    }
    func observeFoodChange(tag: String) {
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).child(fommaterDate.string(from: date)).child("foods").child(tag).observe(.value) { snapshot in
            guard let newValue = snapshot.value as? [String: Any] else {
                print("Error")
                return
            }
            var foodArray: [FoodRead] = []
            for (key, data) in newValue {
                if let foodData = data as? [String: Any] {
                    let food = FoodRead(id: key, data: foodData)
                    foodArray.append(food)
                }
            }
            self.foods = foodArray
        }
    }
    func observeGoalFromFirebase() {
        fommaterDate.dateFormat = "yyyy-MM-dd"
        monthDate.dateFormat = "MM월"
        ref.child(monthDate.string(from: date)).observe(.value) { snapshot in
            guard let newValue = snapshot.value as? [String: Any] else {
                print("Error")
                return
            }
            var dateArray: [FirebaseIsGoal] = []
            for (key, data) in newValue {
                if let dateData = data as? [String: Any] {
                    let date = FirebaseIsGoal(id: key, data: dateData)
                    dateArray.append(date)
                }
            }
            self.goals = dateArray
        }
    }
}

struct FoodRead: Identifiable, Codable, Hashable {
    var id: String
    var protein: String
    var fat: String
    var carbohydrate: String
    var calorie: String

    init(id: String, data: [String: Any]) {
        self.id = id // 키 값이 식품명
        self.protein = data["protein"] as? String ?? ""
        self.fat = data["fat"] as? String ?? ""
        self.carbohydrate = data["carbohydrate"] as? String ?? ""
        self.calorie = data["calorie"] as? String ?? ""
    }
}

struct FirebaseIsGoal: Identifiable, Codable, Hashable {
    var id: String
    var isGoal: String

    init(id: String, data: [String: Any]) {
        self.id = id // 키 값이 날짜
        self.isGoal = data["목표 달성 여부"] as? String ?? ""
    }
}


