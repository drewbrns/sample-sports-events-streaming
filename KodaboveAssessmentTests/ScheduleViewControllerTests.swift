//
//  ScheduleViewControllerTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 13/08/2022.
//

import XCTest
@testable import KodaboveAssessment

class ScheduleViewControllerTests: XCTestCase {

    let items = [
        Event(
            id: "1",
            title: "Arsenal vs Ajax",
            subtitle: "Champions League",
            date: .distantPast,
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        ),
        Event(
            id: "2",
            title: "Chelsea vs Manchester Utd",
            subtitle: "EPL",
            date: .distantFuture,
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        )
    ]

    func test_init() {
        let sut = makeSut().vc

        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.prefetchDataSource)
    }

    func test_viewDidLoad_performs_loadData() {
        let exp = expectation(description: "Fetch Data")
        exp.expectedFulfillmentCount = 1

        let sut = makeSut(items: items, expectation: exp)

        XCTAssertNotNil(sut.vc.vm)
        XCTAssertEqual(sut.dataLoader.didCall, 0)
        XCTAssertTrue(sut.vc.vm!.isEmpty)

        sut.vc.viewDidLoad()

        wait(for: [exp], timeout: 1)

        XCTAssertEqual(sut.dataLoader.didCall, 1)
        XCTAssertFalse(sut.vc.vm!.isEmpty)

        XCTAssertEqual(sut.vc.tableView.numberOfSections, 1)

        // Fake pagination, assumes there are 100 items in the list
        XCTAssertEqual(sut.vc.tableView.numberOfRows(inSection: 0), 100)

        sut.vc.vm?.stopLoadingData()
    }

    func test_init_cell() {
        let exp = expectation(description: "Fetch Data")
        exp.expectedFulfillmentCount = 1

        let sut = makeSut(items: items, expectation: exp)

        sut.vc.viewDidLoad()

        wait(for: [exp], timeout: 1)

        let cell = sut.vc.tableView.cell(at: 0)
        XCTAssertNotNil(cell?.itemTitleLabel)
        XCTAssertNotNil(cell?.itemSubTitleLabel)
        XCTAssertNotNil(cell?.itemDateLabel)
        XCTAssertNotNil(cell?.itemImageView)

        sut.vc.vm?.stopLoadingData()
    }

    func test_cellForRowAtIndexPath_renders_cell_correctly() {
        let exp = expectation(description: "Fetch Data")
        exp.expectedFulfillmentCount = 1

        let sut = makeSut(items: items, expectation: exp)
        sut.vc.viewDidLoad()

        wait(for: [exp], timeout: 1)

        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.title(at: 0)), "Arsenal vs Ajax")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.title(at: 1)), "Chelsea vs Manchester Utd")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.subTitle(at: 0)), "Champions League")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.subTitle(at: 1)), "EPL")

        sut.vc.vm?.stopLoadingData()
    }

    // MARK: Helpers

    func makeSut(
        items: [Event] = [],
        expectation: XCTestExpectation? = nil
    ) -> (vc: ScheduleViewController, dataLoader: DataLoaderSpy) {

        let dataLoader = DataLoaderSpy(items: items)
        dataLoader.expectation = expectation

        let vm = EventListViewModel(dataLoader: dataLoader)

        let vc = AppStoryboard.main.viewController(
            viewControllerClass: ScheduleViewController.self
        )
        _ = vc.view
        vc.vm = vm
        vc.fetchDataWaitPeriod = 1

        return (vc, dataLoader)
    }

}

private extension UITableView {

    func cell(at row: Int) -> ListItemCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0)) as? ListItemCell
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.itemTitleLabel.text
    }

    func subTitle(at row: Int) -> String? {
        return cell(at: row)?.itemSubTitleLabel.text
    }

    func date(at row: Int) -> String? {
        return cell(at: row)?.itemDateLabel.text
    }

}
