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

                HStack(spacing: 5) {
                    VStack {
                        Image(systemName: "calendar.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("이건 날짜")
                        Text(date, style: .date)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.black)
                            .bold()
                    }
                    .padding()
                    
                    VStack {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("목표를 달성한 날")
                        Text("0 / 31") // 숫자 받아오기
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.black)
                            .bold()
                    }
                    .padding()
                    VStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("이건 시간")
                        Text(date, style: .time)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.black)
                            .bold()
                    }
                    .padding()
                }
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
