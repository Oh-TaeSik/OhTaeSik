//
//  InputInfoView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct InputInfoView: View {
    
    @State var height: String = ""
    @State var weight: String = ""
    @State var birth : String = ""
    @State var selected = 0
    @State var tag:Int? = nil
    
    @State var isSaved = false
    @State var userData: User
    
    @Binding var signInData: SignInData
    
    var body: some View {
        VStack {
            
            //            MyPageView(signInData: .constant(SignInData(url: signInData.url, name: signInData.name, email: "이메일")))
            //                .tabBarItem(tab: .profile, selection: $tabSelection)
            
            Text("어이 오태식이\n신체 정보 입력은 필수!")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, weight: .semibold))
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .padding(50)
            
            VStack {
                TextField("키", text: $height)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(10)
                
                TextField("몸무게", text: $weight)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(10)
                
                TextField("생년월일", text: $birth)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(10)
                
                Picker(selection: $selected, label: Text(""), content: {
                    Text("남자").tag(0)
                    Text("여자").tag(1)
                }).pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(width: 300)
                    .padding(5)
            }
            
            ZStack{
                NavigationLink(destination: AppTabBarView(userData: .constant(User(id: "", name: signInData.name, weight: weight, height: height, birth: birth, gender: selected, calorie: 0.0))) , tag: 1, selection: self.$tag ) {
                    EmptyView()
                }
                
                Button( action : {
                    self.tag = 1
                }) {
                    Text("시작하기")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 25, weight: .semibold))
                        .shadow(color: .gray, radius: 5, x: 3, y: 3)
                        .padding(50)
                        .foregroundColor(Color.black)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
