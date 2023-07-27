//
//  CalendarView.swift
//  OhTaeSik
//
//  Created by 이승진 on 2023/07/26.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                Text(date, style: .date)
                HStack {
                    Text("성공")
                        .font(.system(size: 30, weight: .semibold))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        .foregroundColor(Color.blue)
                    Text("실패")
                        .font(.system(size: 30, weight: .semibold))
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        .foregroundColor(Color.red)
                }
                .padding()
            }
            .navigationTitle("오태식")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
