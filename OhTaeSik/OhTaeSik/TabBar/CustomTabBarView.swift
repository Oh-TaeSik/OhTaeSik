//
//  CustomTabBarView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    @Binding var selection: TabBarItem
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(width: 100)
        .background(localSelection == tab ? tab.color.opacity(0.2) : .clear)
        .cornerRadius(10)
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
    
    private func switchToTabWithAnimation(tab: TabBarItem) {
            withAnimation(.easeInOut) {
                selection = tab
            }
        }
        
        private var tabBarVersion1: some View {
            HStack {
                ForEach(tabs, id:\.self) { tab in
                    tabView(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                }
            }
            .padding(6)
            .background(
                Color.white.ignoresSafeArea(edges: .bottom)
            )
        }
    }

extension CustomTabBarView {
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(width: 100)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id:\.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.black.ignoresSafeArea(edges: .bottom)
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
