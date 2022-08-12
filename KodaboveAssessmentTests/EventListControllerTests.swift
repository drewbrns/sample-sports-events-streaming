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
            title: "Chelsea vs Manchester Utd",
            subTitle: "EPL",
            date: .distantFuture,
            imageURL: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "2",
            title: "Manchester Utd vs Juventus",
            subTitle: "Champions League",
            date: Date(),
            imageURL: URL(string: "https://via.placeholder.com/150")!
        ),
        Item(
            id: "3",
            title: "Arsenal vs Ajax",
            subTitle: "Champions League",
            date: .distantPast,
            imageURL: URL(string: "https://via.placeholder.com/150")!
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
        XCTAssertEqual(sut.vc.tableView.numberOfRows(inSection: 0), 3)
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

    final class DataLoaderSpy: ItemLoader {
        private(set) var didCall = 0
        private var items: [Item]

        init(items: [Item]) {
            self.items = items
        }

        func fetch(page: Int, limit: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
            didCall += 1
            completion(.success(self.items))
        }
    }
}

private extension UITableView {

    func cell(at row: Int) -> ListItemCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0)) as? ListItemCell
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.itemTitleLabel.text
    }

    func itemSubTitle(at row: Int) -> String? {
        return cell(at: row)?.itemSubTitleLabel.text
    }

    func date(at row: Int) -> String? {
        return cell(at: row)?.itemDateLabel.text
    }

}
