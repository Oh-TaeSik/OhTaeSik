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
//    var breakfast: [food]
//    var lunch: [food]
//    var dinner: [food]
//    var dessert: [food]
}

struct food {
    var foodName: String
    var foodCalorie: String
    var food탄수: String
    var food단백: String
    var food지방: String
}
