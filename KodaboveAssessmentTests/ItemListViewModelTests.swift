//
//  ListItemViewModelTests.swift
//  KodaboveAssessmentTests
//
//  Created by Drew Barnes on 10/08/2022.
//

import XCTest
@testable import KodaboveAssessment

class ItemListViewModelTests: XCTestCase {

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
            date: .distantPast,
            imageURL: URL(string: "https://via.placeholder.com/150")!
        )
    ]

    func test_viewModel_contains_no_items() {
        let sut = makeSut()
        XCTAssertTrue(sut.isEmpty)
    }

    func test_viewModel_contains_items_after_fetching_data() {
        let sut = makeSut(items: items)
        sut.loadData()

        XCTAssertFalse(sut.isEmpty)
    }

    func test_viewModel_at_index_returns_data_correctly() {
        let sut = makeSut(items: items)
        sut.loadData()

        XCTAssertEqual(
            sut.viewModel(at: 0),
            ItemViewModel(item: items[0])
        )
        XCTAssertEqual(
            sut.viewModel(at: 1),
            ItemViewModel(item: items[1])
        )
    }

    func test_loaded_items_are_sorted_by_date_in_ascending_order() {
        let sut = makeSut(items: items)
        sut.loadData()

        let date1 = sut.viewModel(at: 0).date
        let date2 = sut.viewModel(at: 1).date

        XCTAssertTrue(date1 < date2)
    }

    // MARK: - Helpers
    func makeSut(items: [Item] = []) -> ItemListViewModel {
        let itemLoader = ItemLoaderStub()
        itemLoader.items = items
        return ItemListViewModel(dataLoader: itemLoader)
    }

    final class ItemLoaderStub: ItemLoader {
        var items: [Item] = []

        func fetch(page: Int, limit: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
            completion(.success(self.items))
        }
    }

}
