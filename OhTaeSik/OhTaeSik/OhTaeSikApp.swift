//
//  OhTaeSikApp.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

class DataModel: ObservableObject {
    @Published var meals: String = ""
    @Published var totalCalorie: Double = 0
}

@main
struct OhTaeSikApp: App {
    @ObservedObject var appState = AppState()
    @StateObject var dataModel = DataModel()

    init() {
        FirebaseApp.configure()
    }
    
    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            GoogleSignInView(signInData: SignInData(url:nil, name:"", email:""))
                .onOpenURL { url in GIDSignIn.sharedInstance.handle(url)
                }
                .id(appState.rootViewId)
                .environmentObject(appState)
                .environmentObject(dataModel)

        }
    }
}
