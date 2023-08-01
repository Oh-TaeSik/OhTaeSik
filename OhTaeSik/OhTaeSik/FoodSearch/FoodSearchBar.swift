//
//  FoodSearchBar.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI
 
struct FoodSearchBar: View {
    
    @Binding var text: String
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
 
                TextField("Food", text: $text)
                    .foregroundColor(.primary)
                    .font(.system(size: 20, weight: .medium))
                    .padding(8)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
    }
}
