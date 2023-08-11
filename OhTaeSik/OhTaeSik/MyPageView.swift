//
//  MyPageView.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/07/27.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase

struct MyPageView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = UserReadViewModel()
    private let database = Database.database().reference()
    private let user = Auth.auth().currentUser
    private var userName: String = ""
    private var height: String = ""
    private var weight: String = ""
    private var calorie: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 180)
                .scaledToFill()
            
            
            VStack(spacing: 70){
                AsyncImage(url: user?.photoURL)
                    .imageScale(.small)
                    .foregroundColor(Color.white)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 4))
                    .offset(y: -80)
                    .padding(.bottom, -130)
                
                Text(viewModel.user.name)
                    .bold()
                    .font(.title)
                
            }
            .onAppear() {
                viewModel.observeNameData(uid: user!.uid)
            }
            
            VStack(spacing: 5){
                Text(viewModel.user.height + "cm")
                    .font(.system(size: 20, weight: .semibold))
                
                Text(viewModel.user.weight + "kg")
                    .font(.system(size: 20, weight: .semibold))
                    
            }.onAppear() {
                viewModel.observeHeightData(uid: user!.uid)
                viewModel.observeWeightData(uid: user!.uid)
            }.padding(30)
            
            
            VStack(spacing: 30) {
                Text("1일 권장 칼로리")
                    .foregroundColor(Color.red)
                    .font(.system(size: 24, weight: .semibold))
                    .shadow(radius: 2)
                Text(String(viewModel.user.calorie) + "kcal")
                    .font(.system(size: 26, weight: .bold))
                    .shadow(radius: 2)
            }.onAppear() {
                viewModel.observeCalorieData(uid: user!.uid)
            }.padding(40)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(14)
            
            VStack {
                Button {
                    do {
                        try Auth.auth().signOut()
                        appState.rootViewId = UUID()
                    }
                    catch {
                        print("signOut error")
                    }
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
