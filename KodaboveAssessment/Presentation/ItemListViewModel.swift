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
    func viewModel(at index: Int) -> ItemViewModel
}

final class ItemListViewModel: ObservableObject, ItemList {
    @Published private(set) var onFetchComplete: Bool = false
    @Published private(set) var onError: Error?

    var isEmpty: Bool { items.isEmpty }
    var totalCount: Int { items.count }
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
        self.dataLoader.fetch(page: self.currentPage, limit: limit) { result in
            self.isLoadingData = false

            switch result {
            case .success(let items):
                self.currentPage += 1
                self.items = items
                self.onFetchComplete = true
            case .failure(let error):
                self.onError = error
            }
        }
    }

    func viewModel(at index: Int) -> ItemViewModel {
        return ItemViewModel(item: items[index])
    }

}
