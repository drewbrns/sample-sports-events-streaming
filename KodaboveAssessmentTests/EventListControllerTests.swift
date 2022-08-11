//
//  EventListControllerTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 11/08/2022.
//

import XCTest
@testable import KodaboveAssessment

class EventListControllerTests: XCTestCase {

    func test_init() {
        XCTFail()
    }

    // MARK: Helpers

    func makeSut() -> EventListViewController {
        let sut = AppStoryboard.main.viewController(viewControllerClass: EventListViewController.self)
        _ = sut.view
        return sut
    }

}
