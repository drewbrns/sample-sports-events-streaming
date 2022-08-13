//
//  ItemViewModel.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation

struct ItemViewModel {
    private var item: Item

    enum ItemType {
        case event
        case schedule
    }
    private var itemType: ItemType

    var id: String {
        return item.id
    }
    var title: String {
        item.title
    }
    var subTitle: String {
        item.subTitle
    }
    var imageUrl: URL {
        item.imageURL
    }
    var videoUrl: URL? {
        item.videoURL
    }
    var date: Date {
        return item.date
    }

    init(item: Item, itemType: ItemType = .event) {
        self.item = item
        self.itemType = itemType
    }

    var dateForDisplay: String {
        switch itemType {
        case .event:
            return dateForDisplayForEvent
        case .schedule:
            return dateForDisplayForSchedule
        }
    }

    private var dateForDisplayForEvent: String {
        Formatter.dateFormatter.dateFormat = getDateFormat(for: self.date)
        let dateString = Formatter.dateFormatter.string(from: self.date)

        if self.date.isYesterday {
            return "Yesterday, \(dateString)"
        } else if self.date.isToday {
            return "Today, \(dateString)"
        }

        return dateString
    }

    private var dateForDisplayForSchedule: String {
        if self.date.isToday {

        } else if self.date.isTomorrow {

        } else if self.date.isInPast {

        }
        return ""
    }

    private func getDateFormat(for date: Date) -> String {
        if date.isYesterday || date.isToday {
            return "HH:mm"
        }
        return "dd.MM.yyyy"
    }

}

extension ItemViewModel: Equatable {
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        return lhs.item == rhs.item
    }
}
