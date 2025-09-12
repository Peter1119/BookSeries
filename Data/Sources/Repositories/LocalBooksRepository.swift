//
//  LocalBooksRepository.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation
import Domain

public struct LocalBooksRepository: BooksRepository {
    private let dataLoader: DataLoading
    private let decoder: JSONDataDecoder<BookSeriesDTO> // 이제 디코더를 주입받습니다.
    
    public init(
        dataLoader: DataLoading,
        decoder: JSONDataDecoder<BookSeriesDTO>
    ) {
        self.dataLoader = dataLoader
        self.decoder = decoder
    }
    
    public func fetchAll() async throws -> [Domain.Book] {
        let data = try dataLoader.loadData(forResource: "data", withExtension: "json")
        let bookSeriesDTO = try decoder.decode(data)
        return bookSeriesDTO.data.map { $0.toDomain() }
    }
}
