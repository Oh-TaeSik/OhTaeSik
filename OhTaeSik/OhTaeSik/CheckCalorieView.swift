//
//  CheckCalorieView.swift
//  Test03
//
//  Created by 이승진 on 2023/07/29.
//

import SwiftUI
import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CheckCalorieView: View {
    @StateObject var viewModel = ReadViewModel()
    @EnvironmentObject var dataModel: DataModel
    @State private var foods: [Food] = [] // 음식들을 배열로 관리합니다
    @State private var isActive: Bool = false
    @State private var tag: [String] = ["아침", "점심", "저녁", "간식"]
    @State private var mealTotalCalorie = ["", "", "", ""]
    private let database = Database.database().reference()
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    PieChartView(values: viewModel.totalNutrients,
                                 names: ["탄수화물", "단백질", "지방"],
                                 formatter: {value in String(format: "%.1f(kcal)", value)})
                } label: {
                    SummaryView(viewModel: viewModel)
                        .navigationTitle("오태식")
                }
                .onAppear() {
                    viewModel.observeTotalCalorie()
                    viewModel.observeTotalNutrients()
                }
                Spacer()
                    .frame(height: 60)
                VStack {
                    HStack {
                        NavigationLink {
                            DietView(mealsWhen: $tag[0])
                                .navigationBarTitle("아침", displayMode: .inline)
                        } label: {
                            Image("sandwich")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack (alignment: .leading){
                                HStack {
                                    Text("아침")
                                    if viewModel.values[0] != nil {
                                        Text("\(viewModel.values[0]!) kcal")
                                    } else {
                                        Text("0 kcal")
                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[0], index: 0)
                        }
                        Spacer()
                            .frame(width: 80)
                        
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[0])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.black)
                                .frame(alignment: .trailing)

                        }
                    }
                    Divider()
                        .frame(height: 1)
                    
                    HStack {
                        NavigationLink {
                            DietView(mealsWhen: $tag[1])
                                .navigationBarTitle("점심", displayMode: .inline)
                        } label: { 
                            Image("sushi")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("점심")
                                    if viewModel.values[1] != nil {
                                        Text("\(viewModel.values[1]!) kcal")
                                    } else {
                                        Text("0 kcal")
                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[1], index: 1)
                        }
                        Spacer()
                            .frame(width: 80)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[1])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    Divider()
                        .frame(height: 1)
                    
                    HStack {
                        NavigationLink {
                            DietView(mealsWhen: $tag[2])
                                .navigationBarTitle("저넉", displayMode: .inline)
                        } label: {
                            Image("chicken")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("저녁")
                                    if viewModel.values[2] != nil {
                                        Text("\(viewModel.values[2]!) kcal")
                                    } else {
                                        Text("0 kcal")
                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[2], index: 2)
                        }
                        Spacer()
                            .frame(width: 80)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[2])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.black)

                        }
                    }
                    Divider()
                        .frame(height: 1)
                    
                    HStack {
                        NavigationLink {
                            DietView(mealsWhen: $tag[3])
                                .navigationBarTitle("간식", displayMode: .inline)
                        } label: {
                            Image("cake")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("간식")
                                    if viewModel.values[3] != nil {
                                        Text("\(viewModel.values[3]!) kcal")
                                    } else {
                                        Text("0 kcal")
                                    }
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[3], index: 3)
                        }
                        Spacer()
                            .frame(width: 80)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[3])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.black)

                        }
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.90)
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                )
                .onAppear() {
                    
                }
            }
            .offset(y:-50)
        }
        .background(.black)
        .navigationBarBackButtonHidden()
    }
}

struct SummaryView: View {
    @ObservedObject var viewModel = ReadViewModel()
    @StateObject var userViewModel = UserReadViewModel()
    private let user = Auth.auth().currentUser

    var body: some View {
        VStack {
            HStack (spacing: 50){
                VStack(spacing:5) {
                    Text("섭취 칼로리")
                        .bold()
                        .font(.system(size: 18))
                    if viewModel.totalCalorie != nil {
                        Text("\(String(format: "%.1f", Double(viewModel.totalCalorie!)!)) kcal")
                    } else {
                        Text("0 kcal")
                    }
                }
                VStack(spacing:5) {
                    Text("잔여 칼로리")
                        .bold()
                        .font(.system(size: 18))
                    if viewModel.totalCalorie != nil {
                        Text("\(String(format: "%.1f", (userViewModel.user.calorie - Double(viewModel.totalCalorie!)!))) kcal")
                    } else {
                        Text("0 kcal")
                    }
                }
                .onAppear() {
                    userViewModel.observeCalorieData(uid: user!.uid)
                }
            }
        }
        .foregroundColor(Color.black)
        .padding()
        .frame(width: UIScreen.main.bounds.width*0.90)
        .frame(height: 100)
        .overlay (
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .foregroundColor(.black)
        )
    }
}

struct Previews_CheckCalorieView_Previews: PreviewProvider {
    static var previews: some View {
        CheckCalorieView()
    }
}
