//
//  Item.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: String
    var title: String
    var subtitle: String
    var date: Date
    var imageUrl: URL
    var videoUrl: URL?
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

extension Item: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
