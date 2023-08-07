//
//  MyPageView.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/07/27.
//

import SwiftUI
import GoogleSignIn

struct MyPageView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var signInData: SignInData
    
    @State var nickname: String = ""
    @State var calorie: String = ""
    
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
            
            VStack {
                TextField("키", text: $nickname)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(10)
                
                TextField("몸무게", text: $nickname)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(10)
            }
            
            VStack {
                Text("1일 권장 칼로리")
                    .foregroundColor(Color.red)
                    .font(.system(size: 26, weight: .bold))
                    .shadow(radius: 2)
                    .padding()
                Text("\(calorie) Kcal")
                    .bold()
            }
            
            VStack {
                Button {
                    // 업데이트 누를 시 키, 몸무게 입력 정보가 갱신되어 권장칼로리 계산됨.
                } label: {
                    Text("업데이트")
                        .padding()
                        .frame(width: 300)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .padding(30)
                        .bold()
                }
                Button {
                    GIDSignIn.sharedInstance.signOut()
                    dismiss()
                } label: {
                    Text("로그아웃")
                        .foregroundColor(.black)
                        .bold()
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(signInData: .constant(SignInData(url: nil, name: "이름", email: "이메일")))
    }
}
