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

    var isInPast: Bool {
        self < Date()
    }

    var isYesterday: Bool {
        calendar.isDateInYesterday(self)
    }

    var isToday: Bool {
        calendar.isDateInToday(self)
    }

    var isTomorrow: Bool {
        calendar.isDateInTomorrow(self)
    }

    func daysFrom(date: Date) -> Int {
        return calendar.daysBetween(date, and: self)
    }

    func daysTo(date: Date) -> Int {
        return calendar.daysBetween(self, and: date)
    }
}
