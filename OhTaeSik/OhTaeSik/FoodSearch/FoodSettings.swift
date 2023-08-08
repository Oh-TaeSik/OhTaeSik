//
//  FoodSettings.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/09.
//

import Foundation

class FoodSettings: ObservableObject {
    @Published var foodDefaults = UserDefaults.standard
}
