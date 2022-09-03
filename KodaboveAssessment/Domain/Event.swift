//
//  Item.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation

struct Event: Identifiable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let date: Date
    var imageUrl: URL
    var videoUrl: URL?
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
}

extension Event: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
