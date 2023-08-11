//
//  GoogleLoginView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/27.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

struct GoogleSignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var vm = GoogleSignInViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 50) {
                    Text("오태식")
                        .font(.system(size: 100, weight: .semibold))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    Button {
                        vm.signInWithGoogle()
                    } label: {
                        Image("googleLogin")
                            .resizable()
                            .frame(width: 320, height: 55)
                    }
                    
                    NavigationLink("", destination: AddNewUserInfoView(userStore: UserStore()), isActive: $vm.isLoginSuccessed)
                        .opacity(0)
                }
            }
        }
    }
}

