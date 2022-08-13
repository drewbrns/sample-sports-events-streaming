//
//  TestHelpers.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 12/08/2022.
//

import Foundation
import XCTest
@testable import KodaboveAssessment

final class TimeTraveler {
    private var date = Date()

    func travel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }

    func travel(by days: Int) {
        var components = DateComponents()
        components.day = days
        guard let newDate = Calendar.current.date(byAdding: components, to: date) else { return }
        date = newDate
    }

    func getSpecificDate(hour: Int, min: Int, second: Int=0) -> Date {
        return Calendar.current.date(
            bySettingHour: hour, minute: min, second: second, of: date
        )!
    }

    func generateDate() -> Date {
        return date
    }

}

final class DataLoaderSpy: ItemLoader {
    private(set) var didCall = 0
    var expectation: XCTestExpectation?
    var items: [Item] = []

    init(items: [Item]) {
        self.items = items
    }

    func fetch(page: Int, limit: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        didCall += 1
        expectation?.fulfill()
        completion(.success(self.items))
    }
}
