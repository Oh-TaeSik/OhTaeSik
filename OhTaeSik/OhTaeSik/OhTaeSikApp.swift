//
//  OhTaeSikApp.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
import GoogleSignIn
import Firebase

@main
struct OhTaeSikApp: App {
    var body: some Scene {
        WindowGroup {
            GoogleSignInView(userData: SignInData(url:nil, name:"", email:""))
                .onOpenURL { url in GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
