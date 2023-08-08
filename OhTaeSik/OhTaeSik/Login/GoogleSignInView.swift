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

//class Signin_withGoogle_VM: ObservableObject {
//    @Published var isLoginSuccessed = false
//
//    func signInWithGoogle() {
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            fatalError("No client ID found in Firebase configuration")
//        }
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        // Sign in method with updated code
//        if let presentingViewController = UIApplication.shared.windows.first?.rootViewController {
//            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
//                // Handle signIn completion here
//            }
//        }
//    }
//}

class Signin_withGoogle_VM: ObservableObject {
    @Published var isLoginSuccessed = false

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        //sign in method goes here
        GIDSignIn.sharedInstance.signIn(
            withPresenting: Application_utility.rootViewController) { user, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard
                    let user = user?.user,
                    let idToken = user.idToken else {return}
                
                let accessToken = user.accessToken
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { res, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    guard let user = res?.user else {return}
                    print(user)
                }
        }
    }
}
struct GoogleSignInView: View {
    @State var isLogined = false
    @State var isAlert = false
    @State var signInData: SignInData
    @StateObject private var vm = Signin_withGoogle_VM()
    typealias UIViewControllerType = UIViewController
    
    public init(isLogined: Bool = false, signInData: SignInData) {
        _isLogined = State(initialValue: isLogined)
        _signInData = State(initialValue: signInData)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Button {
//                    googleLogin()
                    vm.signInWithGoogle()
                } label: {
                    Text("구글 로그인")
                }
            }.navigationDestination(isPresented: $isLogined, destination: {
                AddNewUserInfoView(userStore: UserStore(), signInData: $signInData)
                //                AddNewUserInfoView(userData: User(id: "", name: "", weight: "", height: "", birth: Date.now, gender: 0, calorie: 0.0), signInData: $signInData)
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

