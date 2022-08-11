//
//  IndexPath+Additions.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import Foundation

extension IndexPath {
    static func generateIndexPaths(rowStart: Int, rowEnd: Int, section: Int = 0) -> [IndexPath] {
        let startIndex = rowStart - rowEnd
        let endIndex = startIndex + rowEnd
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: section) }
    }
}
