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
        let data: Data
        
        do {
            // 데이터 로딩 시 발생할 수 있는 에러만 여기서 잡습니다.
            data = try dataLoader.loadData(forResource: "data", withExtension: "json")
        } catch {
            // 로딩 에러는 BookError.fileNotFound로 변환
            throw BookError.fileNotFound
        }
        
        do {
            // 데이터 디코딩 시 발생할 수 있는 에러만 여기서 잡습니다.
            let bookSeriesDTO = try decoder.decode(data)
            return bookSeriesDTO.data.map { $0.toDomain() }
        } catch {
            // 디코딩 에러는 BookError.parsingFailed로 변환
            // (이 부분은 DecodingError로 특정할 수도 있습니다.)
            throw BookError.parsingFailed
        }
    }
}
