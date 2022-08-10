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

final class RemoteItemLoader: ItemLoader {
    
    private var resource: String

    init(resource: String) {
        self.resource = resource
    }

    func fetch(page: Int, limit: Int, completion: @escaping (Result<[Item], Error>) -> Void) {

    }

}
