//
//  MyPageView.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/07/27.
//

import SwiftUI

struct MyPageView: View {
    @State var nickname: String = ""
    @State var calorie: String = ""
    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 150) // <- 200을 300으로 변경
                CircleImage()
                    .offset(y: -100)
                    .padding(.bottom, -130)
            }
            .frame(maxHeight: 200)
            .padding(.top, 30)
            Text("\(nickname)이름")
                .bold()
                .font(.title)
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
            Text("1일 권장 칼로리")
                .foregroundColor(Color.red)
                .bold()
                .shadow(radius: 2)
                .padding()
            Text("\(calorie) Kcal")
                .bold()
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
            HStack{
                Button {
                    // 로그아웃이 되도록 실행 코드
                } label: {
                    Text("로그아웃")
                        .foregroundColor(.black)
                        .bold()
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}


struct CircleImage : View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .foregroundColor(Color.white)
            .frame(width: 130, height: 130)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 4))
            
    }
}
