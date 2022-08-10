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
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.subTitle == rhs.subTitle &&
        lhs.date == rhs.date &&
        lhs.imageURL == rhs.imageURL &&
        lhs.videoURL == rhs.videoURL
    }
}
