//
//  DietView.swift
//  Test03
//
//  Created by 이승진 on 2023/08/02.
//

import SwiftUI
import FirebaseDatabase
struct DietView: View {
    @State private var foods: [Food] = [] // 음식들을 배열로 관리합니다
    @EnvironmentObject var dataModel: DataModel
    @StateObject var viewModel = ReadViewModel()
    @Binding var mealsWhen: String // 아침, 점심, 저녁

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.foods, id: \.self) { food in // 배열로부터 음식을 렌더링합니다
                    HStack(spacing: 20) {
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack {
                            Text("\(food.id)")
                                .font(.system(size: 24))
                                .bold()
                                .padding(5)
                            Text("탄수화물: \(food.carbohydrate)")
                            Text("단백질: \(food.protein)")
                            Text("지방: \(food.fat)")
                            Text("칼로리: \(food.calorie)")
//                            Text("총칼로리: \(calorieTotal)")
                        }
                    }
                }
                .padding()
            }
            .onAppear() {
                viewModel.observeFoodChange(tag: mealsWhen)
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


struct DietView_Previews: PreviewProvider {
    static var previews: some View {
        DietView(mealsWhen: .constant("아침")) // 초기값을 넣어줍니다.
    }
}
