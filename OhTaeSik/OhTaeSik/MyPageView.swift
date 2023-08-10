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
    @State var nickname: String = ""
    let database = Database.database().reference()
    let user = Auth.auth().currentUser
    private var userName: String = ""
    private var height: String = ""
    private var weight: String = ""
    private var calorie: String = ""
    
    private func fetchMealTotalCalorieFromFirebase(foodCalorie: Double) {
        
        if let user = Auth.auth().currentUser {
            Database.database().reference().child("users").child("\(user.uid)").child("name").observe(.value) { snapshot in
                if let name = snapshot.value as? String {
                    userName = name
                }
            }
        }
        
        if let user = Auth.auth().currentUser {
            Database.database().reference().child("users").child("\(user.uid)").child("height").observe(.value) { snapshot in
                if let height = snapshot.value as? String {
                    self.height = height
                }
            }
        }
        
        if let user = Auth.auth().currentUser {
            Database.database().reference().child("users").child("\(user.uid)").child("weight").observe(.value) { snapshot in
                if let weight = snapshot.value as? String {
                    self.weight = weight
                }
            }
        }
        
        if let user = Auth.auth().currentUser {
            Database.database().reference().child("users").child("\(user.uid)").child("calorie").observe(.value) { snapshot in
                if let calorie = snapshot.value as? String {
                    self.calorie = calorie
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 10){
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 180)
                .scaledToFill()
            
            VStack(spacing: 70){
                AsyncImage(url: URL(string: ""))
                    .imageScale(.small)
                    .foregroundColor(Color.white)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 4))
                    .offset(y: -80)
                    .padding(.bottom, -130)
                Text(userName)
                    .bold()
                    .font(.title)
                
            }
            
            VStack(spacing: 5){
                Text(height)
                    .font(.system(size: 20, weight: .semibold))
                
                Text(weight)
                    .font(.system(size: 20, weight: .semibold))
                    
            }.padding(30)
            
            VStack(spacing: 30) {
                Text("1일 권장 칼로리")
                    .foregroundColor(Color.red)
                    .font(.system(size: 24, weight: .semibold))
                    .shadow(radius: 2)
                Text(String(calorie) + "kcal")
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
