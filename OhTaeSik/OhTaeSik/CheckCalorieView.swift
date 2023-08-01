//
//  CheckCalorieView.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/07/26.
//

import SwiftUI

struct CheckCalorieView: View {
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
                List() {
                    NavigationLink {
                        FoodSearchView()
                    } label: {
                        Image(systemName: "hourglass.bottomhalf.filled")
                            .resizable()
                            .foregroundStyle(.brown, .brown, .white)
                            .background(.gray)
                            .frame(width: 40)
                        HStack {
                            Text("아침")
                            Text("0 / 1161kcal")
                        }
                    }
                    NavigationLink {
                        FoodSearchView()
                    } label: {
                        Image(systemName: "cup.and.saucer.fill")
                            .resizable()
                            .foregroundStyle(.brown, .brown, .white)
                            .frame(width: 40)
                        HStack {
                            Text("점심")
                            Text("0 / 1161kcal")
                        }
                    }
                    NavigationLink {
                        FoodSearchView()
                    } label: {
                        HStack {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .foregroundStyle(.brown, .brown, .white)
                                .frame(width: 40)
                            HStack {
                                Text("저녁")
                                Text("0 / 1161kcal")
                            }
                        }
                        
                    }
                    NavigationLink {
                        FoodSearchView()
                    } label: {
                        Image(systemName: "birthday.cake")
                            .resizable()
                            .foregroundStyle(.brown, .brown, .white)
                            .frame(width: 40)
                        HStack {
                            Text("간식")
                            Text("0 / 1161kcal")
                        }
                    }
                }
                Spacer()
            }
        }
        .background(.black)
        .navigationBarBackButtonHidden()
    }
}

struct CheckCalorieView_Previews: PreviewProvider {
    static var previews: some View {
        CheckCalorieView()
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
        )
    }
}
