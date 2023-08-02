//
//  InputInfoView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct InputInfoView: View {
    
    @State var nickname: String = ""
    @State private var selected = 0
    @State private var date = Date()
    
    
    var body: some View {
        VStack {
            Text("어이 오태식이\n신체 정보 입력은 필수!")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, weight: .semibold))
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .padding(50)
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
                
                DatePicker(
                    "생년월일",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .padding(9)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(14)
                .frame(width: 300)
                .padding(10)
                
                Picker(selection: $selected, label: Text(""), content: {
                    Text("남자").tag(0)
                    Text("여자").tag(1)
                }).pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(width: 300)
                    .padding(5)
            }
            Text("시작하기")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, weight: .semibold))
                .shadow(color: .gray, radius: 5, x: 3, y: 3)
                .padding(50)
        }
    }
}


struct InputInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InputInfoView()
    }
}
