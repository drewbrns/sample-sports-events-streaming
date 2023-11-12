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

    private var resource: Server.Endpoint
    private var url: URL? {
        Server.url(for: resource)
    }

    init(resource: Server.Endpoint) {
        self.resource = resource
    }

    func fetch(page: Int, limit: Int, completion: @escaping (Result<[Event], Error>) -> Void) {

        guard let url = url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTaskPublisher(for: url).tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: [Event].self, decoder: dateAwareJsonDecoder)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {
            switch $0 {
            case .failure(let error):
                completion(.failure(error))
            case .finished:
                break
            }
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
