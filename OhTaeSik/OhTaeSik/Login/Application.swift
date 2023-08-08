//
//  Application.swift
//  OhTaeSik
//
//  Created by 영서 on 2023/08/08.
//

import SwiftUI
import UIKit
final class Application_utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
