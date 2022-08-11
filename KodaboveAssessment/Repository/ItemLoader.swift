//
//  ItemLoader.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import Foundation

protocol ItemLoader {
    func fetch(
        page: Int,
        limit: Int,
        completion: @escaping (Result<[Item], Error>) -> Void
    )
}
