//
//  RemoteItemLoader.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import Foundation
import Combine

final class RemoteItemLoader: ItemLoader {

    private var cancellables: Set<AnyCancellable> = []

    private var resource: String
    private var url: URL {
        return URL(string: "\(Server.baseUrl)/\(self.resource)")!
    }

    init(resource: Server.endpoints) {
        self.resource = resource.rawValue
    }

    func fetch(page: Int, limit: Int, completion: @escaping (Result<[Item], Error>) -> Void) {

        URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: [Item].self, decoder: dateAwareJsonDecoder)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {
            print("Received completion: \($0).")
        },
        receiveValue: { items in
            completion(.success(items))
        }
        ).store(in: &cancellables)

    }

}

extension RemoteItemLoader {
    private var dateAwareJsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }
}
