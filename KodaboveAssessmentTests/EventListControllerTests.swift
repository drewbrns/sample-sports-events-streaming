//
//  EventListControllerTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 11/08/2022.
//

import XCTest
@testable import KodaboveAssessment

class EventListControllerTests: XCTestCase {

    let items = [
        Item(
            id: "1",
            title: "Arsenal vs Ajax",
            subtitle: "Champions League",
            date: .distantPast,
            imageUrl: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
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
        XCTAssertNotNil(sut.vm)
    }

    func test_viewDidLoad_performs_loadData() {
        let sut = makeSut(items: items)

        XCTAssertNotNil(sut.vc.vm)
        XCTAssertEqual(sut.dataLoader.didCall, 0)
        XCTAssertTrue(sut.vc.vm!.isEmpty)

        sut.vc.viewDidLoad()

        XCTAssertEqual(sut.dataLoader.didCall, 1)
        XCTAssertFalse(sut.vc.vm!.isEmpty)

        XCTAssertEqual(sut.vc.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.vc.tableView.numberOfRows(inSection: 0), 2)
    }

    func test_init_cell() {
        let sut = makeSut(items: items)
        sut.vc.viewDidLoad()

        let cell = sut.vc.tableView.cell(at: 0)
        XCTAssertNotNil(cell?.itemTitleLabel)
        XCTAssertNotNil(cell?.itemSubTitleLabel)
        XCTAssertNotNil(cell?.itemDateLabel)
        XCTAssertNotNil(cell?.itemImageView)
    }

    func test_cellForRowAtIndexPath_renders_cell_correctly() throws {
        let sut = makeSut(items: items)
        sut.vc.viewDidLoad()

        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.title(at: 0)), "Arsenal vs Ajax")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.title(at: 1)), "Chelsea vs Manchester Utd")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.subTitle(at: 0)), "Champions League")
        XCTAssertEqual(try XCTUnwrap(sut.vc.tableView.subTitle(at: 1)), "EPL")
    }

    // MARK: Helpers

    func makeSut(items: [Item] = []) -> (vc: EventListViewController, dataLoader: DataLoaderSpy) {

        let dataLoader = DataLoaderSpy(items: items)
        let vm = ItemListViewModel(dataLoader: dataLoader)

        let vc = AppStoryboard.main.viewController(
            viewControllerClass: EventListViewController.self
        )
        _ = vc.view
        vc.vm = vm

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
