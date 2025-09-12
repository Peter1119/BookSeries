//
//  DataDecoding.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public protocol DataDecoding {
    associatedtype DTO: Decodable
    func decode(_ data: Data) throws -> DTO
}

public struct JSONDataDecoder<DTO: Decodable>: DataDecoding {
    public func decode(_ data: Data) throws -> DTO {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DTO.self, from: data)
    }
}
