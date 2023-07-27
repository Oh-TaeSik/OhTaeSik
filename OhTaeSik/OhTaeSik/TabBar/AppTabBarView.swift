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
            Color.blue
                .tabBarItem(tab: .home, selection: $tabSelection)
            MyPageView()
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
            
            Color.blue
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


struct Previews_AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
