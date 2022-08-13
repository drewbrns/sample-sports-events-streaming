//
//  Date+Additions.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 12/08/2022.
//

import Foundation

extension Calendar {
    func daysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day!
    }
}

extension Date {
    private var calendar: Calendar { Calendar.current }

    var isYesterday: Bool {
        calendar.isDateInYesterday(self)
    }

    var isToday: Bool {
        calendar.isDateInToday(self)
    }

    func daysTo(date: Date) -> Int {
        return calendar.daysBetween(self, and: date)
    }
}
