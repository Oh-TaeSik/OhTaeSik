//
//  LaunchScreenView.swift
//  OhTaeSik
//
//  Created by 지윤 on 2023/07/26.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("오태식")
                    .font(.system(size: 100, weight: .semibold))
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                Text("오늘 내가 택한 식단")
                    .font(.system(size: 30, weight: .medium))
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
