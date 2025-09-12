//
//  LocalBooksRepository.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation
import Domain

public struct LocalBooksRepository: BooksRepository {
    public func fetchAll() async throws -> [Domain.Book] {
        guard let url = Bundle.module.url(forResource: "data", withExtension: "json") else {
            throw BookError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let bookSeriesDTO = try decoder.decode(BookSeriesDTO.self, from: data)
        
        return bookSeriesDTO.data.map { $0.toDomain() }
    }
}
