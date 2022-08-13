//
//  TestHelpers.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 12/08/2022.
//

import Foundation

final class TimeTraveler {
    private var date = Date()

    func travel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }

    func generateDate() -> Date {
        return date
    }
}
