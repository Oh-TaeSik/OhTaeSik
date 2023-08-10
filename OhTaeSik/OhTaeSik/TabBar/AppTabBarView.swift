//
//  AppTabBarView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
import FirebaseAuth

struct AppTabBarView: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        
        CustomTabBarContainerView(selection: $tabSelection) {
            CalendarView()
                .tabBarItem(tab: .calendar, selection: $tabSelection)
            CheckCalorieView()
                .tabBarItem(tab: .home, selection: $tabSelection)
            MyPageView()
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
            
            MyPageView()
                .tabItem {
                    Image(systemName: "Profile")
                    Text("Profile")
                }
        }
    }
}
