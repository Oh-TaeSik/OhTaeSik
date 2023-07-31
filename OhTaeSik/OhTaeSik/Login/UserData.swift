//
//  UserData.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/28.
//

import SwiftUI

struct UserData {
    let url: URL?
    let name: String
    let email: String
    
    init(url: URL?, name: String, email: String) {
        self.url = url
        self.name = name
        self.email = email
    }
}
