//
//  ItemViewModelTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 13/08/2022.
//

import XCTest
@testable import KodaboveAssessment

func getYesterday() -> Date {
    let timeTraveler = TimeTraveler()
    timeTraveler.travel(by: -1)
    return timeTraveler.generateDate()
}

func getTodayAt1130() -> Date {
    let timeTraveler = TimeTraveler()
    return timeTraveler.getSpecificDate(hour: 11, min: 30)
}

class ItemViewModelTests: XCTestCase {

    let items = [
        Item(
            id: "1",
            title: "Arsenal vs Ajax",
            subTitle: "Champions League",
            date: getTodayAt1130(),
            imageURL: URL(string: "https://via.placeholder.com/150")!,
            videoURL: URL(string: "https://via.placeholder.com/150")
        ),
        Item(
            id: "2",
            title: "Chelsea vs Manchester Utd",
            subTitle: "EPL",
            date: getYesterday(),
            imageURL: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "3",
            title: "Liverpool vs Manchester City",
            subTitle: "Community Sheild",
            date: .distantFuture,
            imageURL: URL(string: "https://via.placeholder.com/150")!
        )
    ]

    func test_propertiesAreReturnedCorrectly() throws {
        let item = items[0]
        let sut = makeSut(item: item)
        XCTAssertEqual(sut.id, item.id)
        XCTAssertEqual(sut.title, item.title)
        XCTAssertEqual(sut.subTitle, item.subTitle)
        XCTAssertEqual(sut.imageUrl, item.imageURL)
        XCTAssertEqual(try XCTUnwrap(sut.videoUrl), item.videoURL)
        XCTAssertEqual(sut.date.timeIntervalSinceReferenceDate, item.date.timeIntervalSinceReferenceDate, accuracy: 0.1)
    }

    // MARK: Helpers
    func makeSut(item: Item) -> ItemViewModel {
        return ItemViewModel(item: item)
    }

}
