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
                SummaryView()
                    .navigationTitle("오태식")
                
                Spacer()
//                List() {
//                    VStack {
//                        HStack {
//                            Image(systemName: "hourglass.bottomhalf.filled")
//                                .foregroundStyle(.brown, .brown, .white)
//                                .background(.gray)
//                                .frame(width: 10)
//                            VStack {
//                                Text("아침")
//                                Text("0 / 172kcal")
//                            }
//                            .padding(.horizontal)
//                            Spacer()
//                            Button {
//                                // 실행 코드
//                            } label: {
//                                Image(systemName: "plus.circle.fill")
//                                    .foregroundColor(.blue)
//                            }
//                        }
//
//                    }
//                }
                List() {
                    NavigationLink {
                        Color.red
                    } label: {
                        Image(systemName: "hourglass.bottomhalf.filled")
                            .foregroundStyle(.brown, .brown, .white)
                            .background(.gray)
                            .frame(width: 10)
                        Text("아침")
                    }
                    NavigationLink {
                        Color.red
                    } label: {
                        Image(systemName: "cup.and.saucer.fill")
                            .foregroundStyle(.brown, .brown, .white)
                            .frame(width: 10)
                        Text("점심")
                    }
                    NavigationLink {
                        Color.red
                    } label: {
                        HStack {
                            Image(systemName: "fork.knife.circle")
                                .foregroundStyle(.brown, .brown, .white)
                                .frame(width: 10)
                            VStack {
                                Text("저녁")
                                Text("0 / 1161kcal")
                            }
                        }
                        
                    }
                    NavigationLink {
                        Color.red
                    } label: {
                        Image(systemName: "birthday.cake")
                            .foregroundStyle(.brown, .brown, .white)
                            .frame(width: 10)
                        Text("간식")
                    }
                }
                Spacer()
                
            }
            
            
            
        }
        .background(.blue)
        
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
                    Text("232kcal")
                }
                Spacer()
                VStack {
                    Text("잔여 칼로리")
                    Text("3232kcal")
                }
                Spacer()
            }
            .padding(.bottom)

            HStack {
                Spacer()
                VStack {
                    Text("탄수화물")
                    Text("232g")
                }
                Spacer()
                VStack {
                    Text("단백질")
                    Text("120g")
                }
                Spacer()
                VStack {
                    Text("지방")
                    Text("30g")
                }
                Spacer()
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width*0.90)
        .frame(height: 150)
        .overlay (
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
        )
    }
}
