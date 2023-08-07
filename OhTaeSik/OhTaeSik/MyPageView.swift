//
//  MyPageView.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/07/27.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct MyPageView: View {
    @EnvironmentObject var appState: AppState
    @Binding var signInData: SignInData
    @Binding var userData: User
    @State var nickname: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 180)
                .scaledToFill()
            
            VStack(spacing: 70){
                AsyncImage(url: signInData.url)
                    .imageScale(.small)
                    .foregroundColor(Color.white)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 4))
                    .offset(y: -80)
                    .padding(.bottom, -130)
                Text(signInData.name)
                    .bold()
                    .font(.title)
                
            }
            
            VStack(spacing: 5){
                Text(userData.height + " cm")
                    .font(.system(size: 20, weight: .semibold))
                
                Text(userData.weight + " kg")
                    .font(.system(size: 20, weight: .semibold))
                    
            }.padding(30)
            
            VStack(spacing: 30) {
                Text("1일 권장 칼로리")
                    .foregroundColor(Color.red)
                    .font(.system(size: 24, weight: .semibold))
                    .shadow(radius: 2)
                Text(String(userData.calorie) + "kcal")
                    .font(.system(size: 26, weight: .bold))
                    .shadow(radius: 2)
            }.padding(40)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(14)
            
            VStack {
                Button {
                    GIDSignIn.sharedInstance.signOut()
                    appState.rootViewId = UUID()
                } label: {
                    Text("로그아웃")
                        .padding(50)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
    }
}
