//
//  ContentView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore

class DataModel: ObservableObject {
    @Published var meals: String = ""
    @Published var totalCalorie: Double = 0
}

struct ContentView: View {
    @State var isLoading: Bool = true
    @ObservedObject var appState = AppState()
    @StateObject var dataModel = DataModel()
        
        var body: some View {
            ZStack {
                GoogleSignInView(signInData: SignInData(url:nil, name:"", email:""))
                    .onOpenURL { url in GIDSignIn.sharedInstance.handle(url)
                    }
                    .id(appState.rootViewId)
                    .environmentObject(appState)
                    .environmentObject(dataModel)
                
                if isLoading {
                    LaunchScreenView().transition(.opacity).zIndex(1)
                }
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation { isLoading.toggle() }
                })
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
