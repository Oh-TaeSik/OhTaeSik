//
//  FoodSearchView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
import Foundation
import FirebaseDatabase
class FoodData: ObservableObject {
    @Published var foods: [Food] = []

    func fetchData() {
        // 파이어베이스의 데이터베이스 참조 생성
        let ref = Database.database().reference().child("식품")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Error: Failed to parse snapshot")
                return
            }

            var foodArray: [Food] = []
            for (key, data) in value {
                if let foodData = data as? [String: Any] {
                    let food = Food(id: key, data: foodData)
                    foodArray.append(food)
                }
            }
            self.foods = foodArray
        }
    }
}

struct Food: Identifiable, Codable{
    var id: String
    var protein: String
    var fat: String
    var carbohydrate: String
    var calorie: String

    init(id: String, data: [String: Any]) {
        self.id = id // 키 값이 식품명
        self.protein = data["단백질(g)"] as? String ?? ""
        self.fat = data["지방(g)"] as? String ?? ""
        self.carbohydrate = data["탄수화물(g)"] as? String ?? ""
        self.calorie = data["에너지(kcal)"] as? String ?? ""
    }
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "protein": protein,
            "fat": fat,
            "carbohydrate": carbohydrate,
            "calorie": calorie
        ]
    }
}

struct FoodSearchView: View {
    
    @StateObject private var foodData = FoodData()
    @State private var searchText = ""
    @State private var showingAlert = false
    @State private var selectedFood: Food? = nil // 선택한 음식 저장 변수
    @State private var mealsTotalCalorie = 0.0
    
    @EnvironmentObject var foodSettings: FoodSettings
    @EnvironmentObject var dataModel: DataModel
    
    @Binding var foods: [Food] // 배열로 변경된 바인딩
    @Binding var mealsWhen: String // 아침, 점심 저녁
    
    let database = Database.database().reference()
    
    private func fetchMealTotalCalorieFromFirebase(foodCalorie: Double) {
        
        let ref = database.child("foods").child(mealsWhen)
                // 현재 식사 총 칼로리 가져오기
        ref.child("식사_총_칼로리").observeSingleEvent(of: .value) { (snapshot, arg) in
            if let totalCalories = snapshot.value as? String {
                database.child("foods").child("\(mealsWhen)").child("식사_총_칼로리").setValue(String(Double(totalCalories)! + foodCalorie))
            } else {
                database.child("foods").child("\(mealsWhen)").child("식사_총_칼로리").setValue("\(foodCalorie)")
                print("식사 총 칼로리 데이터를 가져오지 못했습니다.")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                FoodSearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                List {
                    ForEach(foodData.foods.filter {
                        if searchText.isEmpty {
                            return true
                        } else {
                            return $0.id.hasPrefix(searchText.lowercased())
                        }
                    }, id: \.id) { food in
                        HStack {
                            VStack {
                                Text(food.id)
                                    .font(.system(size: 15, weight:.bold))
                                    .padding(.horizontal)
                                Text("100g")
                                    .font(.system(size: 13))
                            }
                            Text("에너지(kcal): \(food.calorie)")
                                .font(.system(size: 15))
                            Spacer()
                            Button {
                                selectedFood = food
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            .alert(item: $selectedFood) { food in
                                Alert(title: Text("영양성분"),
                                      message: Text("단백질(g): \(food.protein)\n지방(g): \(food.fat)\n탄수화물(g): \(food.carbohydrate)"),
                                      primaryButton: .default(Text("추가")) {
                                    foods.append(food)
                                    
                                    fetchMealTotalCalorieFromFirebase(foodCalorie: Double(food.calorie) ?? 0.0)
                                    database.child("foods").child("\(mealsWhen)").child(food.id).setValue(food.toDictionary())
                                    database.child("foods").child("총_칼로리").setValue(dataModel.totalCalorie) // 경로 수정
                                },
                                      secondaryButton: .cancel(Text("취소")))
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarTitle("", displayMode: .inline) // 상단 타이틀 제거
            .font(.system(size: 25, weight: .semibold))
            .onAppear {
                foodData.fetchData()
            }
        }
    }
}


//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodSearchView(foodName: <#T##Binding<String>#>, carbohydrates: <#T##Binding<String>#>, protein: <#T##Binding<String>#>, fat: <#T##Binding<String>#>)
//    }
//}


//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
