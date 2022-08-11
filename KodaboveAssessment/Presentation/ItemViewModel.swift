//
//  ItemViewModel.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation

struct ItemViewModel {
    private var item: Item

    var id: String {
        return item.id
    }
    var date: Date {
        return item.date
    }

    init(item: Item) {
        self.item = item
    }
}

extension ItemViewModel: Equatable {
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        return lhs.item == rhs.item
    }
}
