//
//  AppTabBarView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var tabSelection: TabBarItem = .home
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(tab: .calendar, selection: $tabSelection)
            CheckCalorieView()
                .tabBarItem(tab: .home, selection: $tabSelection)
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $tabSelection) {
            Color.red
                .tabItem {
                    Image(systemName: "Calendar")
                    Text("Calendar")
                }
            
            CheckCalorieView()
                .tabItem {
                    Image(systemName: "Home")
                    Text("Home")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "Profile")
                    Text("Profile")
                }
        }
    }
}


struct Previews_AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
