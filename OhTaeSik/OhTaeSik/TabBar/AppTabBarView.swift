//
//  AppTabBarView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct AppTabBarView: View {
    @Binding var signInData: SignInData
    @Binding var userData: User
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            CalendarView()
                .tabBarItem(tab: .calendar, selection: $tabSelection)
            CheckCalorieView()
                .tabBarItem(tab: .home, selection: $tabSelection)
            MyPageView(signInData: .constant(SignInData(url: signInData.url, name: signInData.name, email: "이메일")), userData: .constant(User(id: "", name: userData.name, weight: userData.weight, height: userData.height, birth: userData.birth, gender: userData.gender, calorie: ((Double(userData.height)! - 100.0) * 0.9)*33)))
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
        
    }
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $tabSelection) {
            CalendarView()
                .tabItem {
                    Image(systemName: "Calendar")
                    Text("Calendar")
                }
            
            CheckCalorieView()
                .tabItem {
                    Image(systemName: "Home")
                    Text("Home")
                }
            
            MyPageView(signInData: .constant(SignInData(url: signInData.url, name: "", email: "이메일")), userData: .constant(User(id: "", name: userData.name, weight: userData.weight, height: userData.height, birth: userData.birth, gender: userData.gender, calorie: ((Double(userData.height)! - 100.0) * 0.9)*33)))
                .tabItem {
                    Image(systemName: "Profile")
                    Text("Profile")
                }
        }
    }
}
