//
//  DietView.swift
//  Test03
//
//  Created by 이승진 on 2023/08/02.
//

import SwiftUI
import FirebaseDatabase
struct DietView: View {
//    @State private var calorieTotal: Double = 0 // 칼로리 총량을 저장할 @State 변수 추가
    @State private var foods: [Food] = [] // 음식들을 배열로 관리합니다
    
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(foods) { food in // 배열로부터 음식을 렌더링합니다
                    HStack {
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack {
                            Text("식품명: \(food.id)")
                            Text("탄수화물: \(food.carbohydrate)")
                            Text("단백질: \(food.protein)")
                            Text("지방: \(food.fat)")
//                            Text("총칼로리: \(calorieTotal)")
                        }
                    }
                }
                .padding()
            }
//            .navigationBarItems(
//                trailing:
//                    NavigationLink(
//                        destination: FoodSearchView(foods: $foods), // 배열을 바인딩으로 전달합니다
//                        label: {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundColor(.blue)
//                })
//            )
        }
    }
    
}

//
//struct DietView_Previews: PreviewProvider {
//    static var previews: some View {
//        DietView(mealscheck: <#Binding<String>#>) // 초기값을 넣어줍니다.
//    }
//}
