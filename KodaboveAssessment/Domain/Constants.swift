//
//  Constants.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import Foundation

enum Server {
    static private let baseUrl = "https://us-central1-dazn-sandbox.cloudfunctions.net"

    enum Endpoint: String {
        case events = "getEvents"
        case schedule = "getSchedule"
    }

    static func url(for endpoint: Endpoint) -> URL? {
        let urlString = Self.baseUrl + "/" + endpoint.rawValue
        return URL(string: urlString)
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

    static var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        return nf
    }()
}
