//
//  EventTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 03/09/2022.
//

import XCTest
@testable import KodaboveAssessment

class EventTests: XCTestCase {

    func testSuccessfulDecode() throws {
        let dateAwareJsonDecoder = JSONDecoder()
        dateAwareJsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

        XCTAssertNoThrow(try dateAwareJsonDecoder.decode(Event.self, from: makeData()))
    }

    // MARK: Test Helpers
    func makeData() -> Data {
        """
        {
            "id": "1",
            "title": "Liverpool v Porto",
            "subtitle": "UEFA Champions League",
            "date": "2022-09-03T01:01:52.060Z",
            "imageUrl": "https://placeholder.com",
            "videoUrl": "https://placeholder.com"
        }
        """.data(using: .utf8)!
    }

}
