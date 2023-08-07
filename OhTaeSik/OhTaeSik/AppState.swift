//
//  AppState.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/04.
//

import Foundation
import Combine

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}
