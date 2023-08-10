//
//  GoogleLoginView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/27.
//

import UIKit
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct GoogleSignInView: View {
    @State var isLogined = false
    @State var isAlert = false
    @State var signInData: SignInData
    
        public init(isLogined: Bool = false, signInData: SignInData) {
            _isLogined = State(initialValue: isLogined)
        _signInData = State(initialValue: signInData)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 100) {
                    Text("오태식")
                        .font(.system(size: 100, weight: .semibold))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    Button {
                        googleLogin()
                    } label: {
                        Image("googleLogin")
                            .resizable()
                            .frame(width: 320, height: 55)
                    }
                }
            }.navigationDestination(isPresented: $isLogined, destination: {
                AddNewUserInfoView(userStore: UserStore(), signInData: $signInData)
            })
        }
        .onAppear(perform: {
            checkState()
        })
        .alert(LocalizedStringKey("로그인 실패"), isPresented: $isAlert) {
            Text("확인")
        } message: {
            Text("다시 시도해주세요")
        }
    }
    
    func checkState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            user, error in if error != nil || user == nil {
                print("Not Sign In")
            } else {
                guard let profile = user?.profile else {
                    return
                }
                let data = SignInData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
                signInData = data
                isLogined = true
                print(isLogined)
            }
        }
    }
    
    func googleLogin() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) {
            signInResult, error in guard let result = signInResult else {
                isAlert = true
                return
            }
            guard let profile = result.user.profile else {
                return
            }
            let data = SignInData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
            signInData = data
            isLogined = true
        }
    }
    
}

