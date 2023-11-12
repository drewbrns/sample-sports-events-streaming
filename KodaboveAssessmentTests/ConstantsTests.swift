//
//  ConstantsTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 12/11/2023.
//

import Foundation
@testable import KodaboveAssessment
import XCTest

class ConstantsTests: XCTestCase {

    func testUrlConstruction() {
        let eventsEndpointUrl = Server.url(for: .events)
        let expectedEventsEndpointUrl = URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getEvents")
        XCTAssertEqual(eventsEndpointUrl, expectedEventsEndpointUrl)

        let scheduleEndpointUrl = Server.url(for: .schedule)
        let expectedScheduleEndpointUrl = URL(string: "https://us-central1-dazn-sandbox.cloudfunctions.net/getSchedule")
        XCTAssertEqual(scheduleEndpointUrl, expectedScheduleEndpointUrl)
    }
}
