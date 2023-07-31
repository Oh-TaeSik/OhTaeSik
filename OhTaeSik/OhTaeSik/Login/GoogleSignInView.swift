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

struct GoogleSignInView: View {
    @State private var isLogined = false
    @State private var isAlert = false
    @State private var userData: UserData
    
    public init(isLogined: Bool = false, userData: UserData) {
        _isLogined = State(initialValue: isLogined)
        _userData = State(initialValue: userData)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Button {
                    googleLogin()
                } label: {
                    Text("구글 로그인")
                }
            }.navigationDestination(isPresented: $isLogined, destination: { MyPageView(userData: $userData)})
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
                let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
                userData = data
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
            let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
            userData = data
            isLogined = true
        }
    }
}
