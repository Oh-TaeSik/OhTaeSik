//
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/04.
//

import SwiftUI
import FirebaseAuth

struct AddNewUserInfoView: View {
    @ObservedObject var userStore : UserStore
    @State var name: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var birth: String = "2023.08.04"
    @State var gender: Int = 1
    @State var tag:Int? = nil
    @State var calorie: Double = 0.0
    @State var selected = 0
    let user = Auth.auth().currentUser
    
    var body: some View {
        Text("어이 오태식이\n신체 정보 입력은 필수!")
            .multilineTextAlignment(.center)
            .font(.system(size: 25, weight: .semibold))
            .shadow(color: .gray, radius: 5, x: 3, y: 3)
            .padding(50)
        
        VStack {
            
            TextField("이름", text: $name)
                .padding()
                .frame(width: 300)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(14)
                .padding(10)
            
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
            NavigationLink(destination: AppTabBarView() , tag: 1, selection: self.$tag ) {
                EmptyView()
            }
            
            Button( action : {
                userStore.addNewUser(user: User(id: user!.uid, name: name, weight: weight, height: height, birth: birth, gender: gender, calorie: calorie))
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
        .navigationBarBackButtonHidden()
    }
    
}
