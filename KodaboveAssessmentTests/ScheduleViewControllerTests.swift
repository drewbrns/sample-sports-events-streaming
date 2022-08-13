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

    // MARK: Helpers

    func makeSut(items: [Item] = []) -> (vc: ScheduleViewController, dataLoader: DataLoaderSpy) {

        let dataLoader = DataLoaderSpy(items: items)
        let vm = ItemListViewModel(dataLoader: dataLoader)

        let vc = AppStoryboard.main.viewController(
            viewControllerClass: ScheduleViewController.self
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

    func subTitle(at row: Int) -> String? {
        return cell(at: row)?.itemSubTitleLabel.text
    }

    func date(at row: Int) -> String? {
        return cell(at: row)?.itemDateLabel.text
    }

}
