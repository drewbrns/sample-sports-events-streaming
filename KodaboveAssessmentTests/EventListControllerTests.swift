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
        let sut = makeSut()

        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.prefetchDataSource)
        XCTAssertNotNil(sut.vm)
    }

    // MARK: Helpers

    func makeSut(items: [Item] = []) -> EventListViewController {

        let vm = ItemListViewModel(items: items)

        let sut = AppStoryboard.main.viewController(viewControllerClass: EventListViewController.self)
        _ = sut.view
        sut.vm = vm
        return sut
    }

    final class ItemListViewModel: ItemList {
        private var items = [Item]()

        var isEmpty: Bool {
            return items.isEmpty
        }
        var totalCount: Int {
            return items.count
        }
        var currentCount: Int {
            return items.count
        }

        init(items: [Item]) {
            self.items = items
        }

        func loadData(limit: Int) {
        }

        func viewModel(at index: Int) -> ItemViewModel {
            ItemViewModel(item: self.items[index])
        }
    }

}
