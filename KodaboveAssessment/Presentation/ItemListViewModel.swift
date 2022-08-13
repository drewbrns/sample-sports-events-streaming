//
//  ItemListViewModel.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation
import Combine

protocol ItemList {
    var isEmpty: Bool { get }
    var totalCount: Int { get }
    var currentCount: Int { get }

    func loadData(limit: Int)
    func loadData(limit: Int, every: Int)
    func viewModel(at index: Int) -> ItemViewModel
}

final class ItemListViewModel: ObservableObject, ItemList {
    @Published private(set) var onFetchComplete: [IndexPath]?
    @Published private(set) var onError: Error?

    var isEmpty: Bool { items.isEmpty }
    private(set) var totalCount: Int = 0
    var currentCount: Int { items.count }

    private var isLoadingData = false
    private var currentPage = 1

    private var items = [Item]()
    private var dataLoader: ItemLoader

    init(dataLoader: ItemLoader) {
        self.dataLoader = dataLoader
    }

    func loadData(limit: Int = 10) {
        guard !isLoadingData else { return }

        self.isLoadingData = true
        self.dataLoader.fetch(page: self.currentPage, limit: limit) { [weak self] result in
            self?.isLoadingData = false

            switch result {
            case .success(let items):
                self?.currentPage += 1
                self?.totalCount = items.count // assuming that api told us the total number of items

                let newItems = self?.sort(items: items) ?? [Item]()
                self?.items = newItems
                let indexPathsToReload = IndexPath.generateIndexPaths(
                    rowStart: items.count,
                    rowEnd: newItems.count
                )
                self?.onFetchComplete = indexPathsToReload
            case .failure(let error):
                self?.onError = error
            }
        }
    }

    func loadData(limit: Int = 10, every: Int) {

    }

    func viewModel(at index: Int) -> ItemViewModel {
        return ItemViewModel(item: items[index])
    }

    private func sort(items: [Item]) -> [Item] {
        return items.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }

    //TODO:
    private func handlePullToRefresh() {
        // don't increase page count (need to preserve this incase user wants to scroll down the list again)
        // inset at the top of the list
        // reload entire data?
    }

    private func handlePaginatedData() {
        // increase page count
        // append data to end of array
        // calcuate new indexes to reload
    }

}
