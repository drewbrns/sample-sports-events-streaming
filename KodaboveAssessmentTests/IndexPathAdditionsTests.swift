//
//  IndexPathAdditionsTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 11/08/2022.
//

import XCTest
@testable import KodaboveAssessment

class IndexPathAdditionsTests: XCTestCase {

    func test_generateIndexPaths_are_correctly_from_range() {
        let sut = IndexPath.generateIndexPaths(rowStart: 20, rowEnd: 10)

        XCTAssertEqual(sut.count, 10)
        XCTAssertEqual(sut[0], IndexPath(row: 10, section: 0))
        XCTAssertEqual(sut[1], IndexPath(row: 11, section: 0))
        XCTAssertEqual(sut[9], IndexPath(row: 19, section: 0))
    }

}
