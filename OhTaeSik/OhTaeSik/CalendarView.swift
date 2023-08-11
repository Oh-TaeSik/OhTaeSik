//
//  CalendarView.swift
//  OhTaeSik
//
//  Created by 이승진 on 2023/07/26.
//

import SwiftUI
import FirebaseDatabase
import FirebaseDatabaseSwift

struct CalendarView: View {
    @StateObject var viewModel = ReadViewModel()
    @State private var date = Date()
    @State private var count = 0
    let fommaterDate = DateFormatter()
    let fommaterDay = DateFormatter()
    let monthDate = DateFormatter()
    let database = Database.database().reference()
    
    func lastDayOfMonth() -> String {
        let calendar = Calendar.current
        let now = Date()
        if let lastDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: calendar.date(from: calendar.dateComponents([.year, .month], from: now))!.addingTimeInterval(-1)) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            return dateFormatter.string(from: lastDay)
        } else {
            return "Invalid date"
        }
    }
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
                
                Spacer()
                    .frame(height: 50)
                HStack(spacing: 5) {
                    VStack {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("목표를 달성한 날")
                            .font(.system(size: 17))
                        Text("\(count) / \(lastDayOfMonth())") // 숫자 받아오기
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.black)
                            .bold()
                            .onAppear() {
                                viewModel.observeGoalFromFirebase()
                            }
                            .onChange(of: viewModel.goals) { newGoals in
                                count = newGoals.filter { $0.isGoal == "True" }.count
                            }
                    }
                    .padding()

                    VStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("현재 시간")
                            .font(.system(size: 17))
                        Text(date, style: .time)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.black)
                            .bold()
                    }
                    .padding()
                }
                Spacer()
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
