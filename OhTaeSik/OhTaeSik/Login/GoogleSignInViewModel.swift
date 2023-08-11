//
//  GoogleSignInViewModel.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/10.
//

import SwiftUI
import Firebase
import GoogleSignIn

class GoogleSignInViewModel: ObservableObject {
    @Published var isLoginSuccessed = false
    @State var isLogined = false
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            if let error = error  {
                print(error.localizedDescription)
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else { return }
                print(user)
                
                self.isLoginSuccessed = true
            }
        }
    }
}
