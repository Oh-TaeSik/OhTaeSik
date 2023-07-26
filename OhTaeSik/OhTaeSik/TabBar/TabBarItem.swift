//
//  TabBarItem.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

enum TabBarItem: Hashable {
    case home, calendar, profile
    
    var iconName: String {
        switch self {
        case .calendar:
            return "calendar"
        case .home:
            return "house"
        case .profile:
            return "person.crop.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .calendar:
            return "Calendar"
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .calendar:
            return Color.white
        case .home:
            return Color.white
        case .profile:
            return Color.white
        }
    }
}
