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
    @ObservedObject var appState = AppState()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            GoogleSignInView(signInData: SignInData(url:nil, name:"", email:""))
                .onOpenURL { url in GIDSignIn.sharedInstance.handle(url)
                }
                .id(appState.rootViewId)
                .environmentObject(appState)
        }
    }
}
