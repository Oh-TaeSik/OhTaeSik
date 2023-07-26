//
//  CustomTabBarContainerView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = [.calendar, .home, .profile]
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            content.ignoresSafeArea()
            CustomTabBarView(tabs: tabs, localSelection: selection, selection: $selection)
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}
