//
//  UserInfo.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/08/02.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var weight: String
    var height: String
    var birth: String
    var gender: Int
    var calorie: Double
}
