//
//  Constants.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import Foundation

struct Server {
    static var baseUrl = "https://us-central1-dazn-sandbox.cloudfunctions.net"

    enum endpoints: String {
        case events = "getEvents"
        case schedule = "getSchedule"

        var toString: String {
            self.rawValue
        }
    }
}

struct PageSize {
    static var limit = 25
}

struct Formatter {
    static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.calendar = Calendar(identifier: .gregorian)
        return df
    }()
}
