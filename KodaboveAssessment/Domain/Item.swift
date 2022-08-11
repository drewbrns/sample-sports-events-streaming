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
    var subTitle: String
    var date: Date
    var imageURL: URL
    var videoURL: URL?
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
