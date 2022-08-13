//
//  ItemViewModelTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 13/08/2022.
//

import XCTest
@testable import KodaboveAssessment

func getTodayAt1130() -> Date {
    let timeTraveler = TimeTraveler()
    return timeTraveler.getSpecificDate(hour: 11, min: 30)
}

func getYesterdayAt1830() -> Date {
    let timeTraveler = TimeTraveler()
    timeTraveler.travel(by: -1)
    return timeTraveler.getSpecificDate(hour: 18, min: 30)
}

func getTomorrowAt1030() -> Date {
    let timeTraveler = TimeTraveler()
    timeTraveler.travel(by: 1)
    return timeTraveler.getSpecificDate(hour: 10, min: 30)
}

func getIn3daysTime() -> Date {
    let timeTraveler = TimeTraveler()
    timeTraveler.travel(by: 3)
    return timeTraveler.getSpecificDate(hour: 18, min: 30)
}

func getIn5daysTime() -> Date {
    let timeTraveler = TimeTraveler()
    timeTraveler.travel(by: 5)
    return timeTraveler.getSpecificDate(hour: 18, min: 30)
}

class ItemViewModelTests: XCTestCase {

    let items = [
        Item(
            id: "1",
            title: "Arsenal vs Ajax",
            subtitle: "Champions League",
            date: getTodayAt1130(),
            imageUrl: URL(string: "https://via.placeholder.com/150")!,
            videoUrl: URL(string: "https://via.placeholder.com/150")
        ),
        Item(
            id: "2",
            title: "Chelsea vs Manchester Utd",
            subtitle: "EPL",
            date: getYesterdayAt1830(),
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "3",
            title: "Liverpool vs Manchester City",
            subtitle: "Community Sheild",
            date: Date(timeIntervalSince1970: 1660220463),
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "4",
            title: "Arsenal vs Ajax",
            subtitle: "Champions League",
            date: getTomorrowAt1030(),
            imageUrl: URL(string: "https://via.placeholder.com/150")!,
            videoUrl: URL(string: "https://via.placeholder.com/150")
        ),
        Item(
            id: "5",
            title: "Chelsea vs Manchester Utd",
            subtitle: "EPL",
            date: getIn3daysTime(),
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "6",
            title: "Liverpool vs Manchester City",
            subtitle: "Community Sheild",
            date: getIn5daysTime(),
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        )
    ]

    func test_propertiesAreReturnedCorrectly() throws {
        let item = items[0]
        let sut = makeSut(item: item)
        XCTAssertEqual(sut.id, item.id)
        XCTAssertEqual(sut.title, item.title)
        XCTAssertEqual(sut.subTitle, item.subtitle)
        XCTAssertEqual(sut.imageUrl, item.imageUrl)
        XCTAssertEqual(try XCTUnwrap(sut.videoUrl), item.videoUrl)
        XCTAssertEqual(sut.date.timeIntervalSinceReferenceDate, item.date.timeIntervalSinceReferenceDate, accuracy: 0.1)
    }

    func test_dateIsFormattedCorrectForDisplay_event() {
        XCTAssertEqual(makeSut(item: items[0]).dateForDisplay, "Today, 11:30")
        XCTAssertEqual(makeSut(item: items[1]).dateForDisplay, "Yesterday, 18:30")
        XCTAssertEqual(makeSut(item: items[2]).dateForDisplay, "11.08.2022")
    }

    func test_dateIsFormattedCorrectForDisplay_schedule() {
        XCTAssertEqual(
            makeSut(
                item: items[0],
                itemType: .schedule
            ).dateForDisplay,
            "Today, 11:30"
        )
        XCTAssertEqual(
            makeSut(
                item: items[3],
                itemType: .schedule
            ).dateForDisplay,
            "Tomorrow, 10:30"
        )
        XCTAssertEqual(
            makeSut(
                item: items[4],
                itemType: .schedule
            ).dateForDisplay,
            "In three days"
        )
    }

    // MARK: Helpers
    func makeSut(item: Item, itemType: ItemType = .event) -> ItemViewModel {
        return ItemViewModel(item: item, itemType: itemType)
    }

}
