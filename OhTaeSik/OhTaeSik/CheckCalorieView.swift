//
//  CheckCalorieView.swift
//  Test03
//
//  Created by 이승진 on 2023/07/29.
//

import SwiftUI

struct CheckCalorieView: View {
    @State private var foods: [Food] = [] // 음식들을 배열로 관리합니다
    @EnvironmentObject var dataModel: DataModel
    @State var tag:Int? = nil
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
                                Text("0 / 1310 kcal")
                            }
                            .foregroundColor(.black)
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods)
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
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
                                Text("0 / 1310 kcal")
                            }
                            .foregroundColor(.black)
                            
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods)
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
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
                                Text("0 / 1310 kcal")
                            }
                            .foregroundColor(.black)
                            
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods)
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
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
                                Text("0 / 1310 kcal")
                            }
                            .foregroundColor(.black)
                            
                        }
                        Spacer()
                            .frame(width: 70)
                        NavigationLink {
                            FoodSearchView(foods: $foods)
                                .navigationBarTitle("무엇을 드셨나요", displayMode: .inline)
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
            }
        }
        .background(.black)
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
