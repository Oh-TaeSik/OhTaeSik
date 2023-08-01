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
            VStack(spacing: 30) {
                Spacer()
                SummaryView()
                    .navigationTitle("오태식")
                   
                
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
                
            }
            
        }
        .offset(y:-30)
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
            HStack(spacing: 60) {
                VStack {
                    Text("섭취 칼로리")
                    Text("232kcal")
                }
                VStack {
                    Text("잔여 칼로리")
                    Text("3232kcal")
                }
            }
            .padding(.bottom)

            HStack(spacing: 60) {
                VStack {
                    Text("단백질")
                    Text("120g")
                }
                VStack {
                    Text("탄수화물")
                    Text("232g")
                }.offset(x:-5)
                VStack {
                    Text("지방")
                    Text("30g")
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width*0.90)
        .frame(height: 150)
        .overlay (
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 0.3)
        )
    }
}
