//
//  CheckCalorieView.swift
//  Test03
//
//  Created by 이승진 on 2023/07/29.
//

import SwiftUI
import FirebaseDatabase

struct CheckCalorieView: View {
    @State private var foods: [Food] = [] // 음식들을 배열로 관리합니다
    @EnvironmentObject var dataModel: DataModel
    @State private var isActive: Bool = false
    @State private var tag: [String] = ["아침", "점심", "저녁", "간식"]
    @State private var mealTotalCalorie = ["", "", "", ""]
    let foodSettings = FoodSettings()
    
    let database = Database.database().reference()
    @StateObject var viewModel = ReadViewModel()
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    PieChartView(values: [1234, 543, 995], names: ["탄수화물", "단백질", "지방"], formatter: {value in String(format: "%.1f(kcal)", value)})
                } label: {
                    SummaryView()
                        .navigationTitle("오태식")
                }
                Spacer()
                    .frame(height: 60)
                VStack {
                    HStack {
                        NavigationLink {
                            DietView()
                                .navigationBarTitle("아침", displayMode: .inline)
                        } label: {
                            Image(systemName: "hourglass.bottomhalf.filled")
                                .resizable()
                                .foregroundStyle(.brown, .brown, .white)
                                .background(.gray)
                                .frame(width: 40, height: 40)
                            HStack {
                                Text("아침")
                                if viewModel.values[0] != nil {
                                    Text("\(viewModel.values[0]!) / 잔여 칼로리")
                                } else {
                                    Text("0")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[0], index: 0)
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[0])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                                .environmentObject(foodSettings)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    Divider()
                        .frame(width: 300, height: 10 )
                    
                    HStack {
                        NavigationLink {
                            DietView()
                                .navigationBarTitle("점심", displayMode: .inline)
                        } label: {
                            Image(systemName: "cup.and.saucer.fill")
                                .resizable()
                                .foregroundStyle(.brown, .brown, .white)
                                .frame(width: 40, height: 40)
                            HStack {
                                Text("점심")
                                if viewModel.values[1] != nil {
                                    Text("\(viewModel.values[1]!) / 잔여 칼로리")
                                } else {
                                    Text("0 / 잔여 칼로리")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[1], index: 1)
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[1])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    Divider()
                        .frame(width: 300, height: 10)
                    
                    HStack {
                        NavigationLink {
                            DietView()
                                .navigationBarTitle("저넉", displayMode: .inline)
                        } label: {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .foregroundStyle(.brown, .brown, .white)
                                .frame(width: 40, height: 40)
                            HStack {
                                Text("저녁")
                                if viewModel.values[2] != nil {
                                    Text("\(viewModel.values[2]!) / 잔여 칼로리")
                                } else {
                                    Text("0 / 잔여 칼로리")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[2], index: 2)
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[2])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    Divider()
                        .frame(width: 300, height: 10)
                    
                    HStack {
                        NavigationLink {
                            DietView()
                                .navigationBarTitle("간식", displayMode: .inline)
                        } label: {
                            Image(systemName: "birthday.cake")
                                .resizable()
                                .foregroundStyle(.brown, .brown, .white)
                                .frame(width: 40, height: 40)
                            HStack {
                                Text("간식")
                                if viewModel.values[3] != nil {
                                    Text("\(viewModel.values[3]!) / 잔여 칼로리")
                                } else {
                                    Text("0 / 잔여 칼로리")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .onAppear() {
                            viewModel.observeDataChange(tag: tag[3], index: 3)
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods, mealsWhen: $tag[3])
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
                                .environmentObject(DataModel())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    Divider()
                        .frame(width: 300, height: 10)
                }
                .padding()
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
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("섭취량")
                        .bold()
                    Text("232kcal")
                }
                Spacer()
                VStack {
                    Text("잔여 칼로리")
                        .bold()
                    Text("3232kcal")
                }
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                VStack {
                    Text("탄수화물")
                        .bold()
                    Text("232g")
                }
                Spacer()
                VStack {
                    Text("단백질")
                        .bold()
                    Text("120g")
                }
                Spacer()
                VStack {
                    Text("지방")
                        .bold()
                    Text("30g")
                }
                Spacer()
            }
        }
        .foregroundColor(Color.black)
        .padding()
        .frame(width: UIScreen.main.bounds.width*0.90)
        .frame(height: 150)
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
