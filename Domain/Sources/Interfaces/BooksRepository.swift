//
//  BookSeriesRepository.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public protocol BooksRepository {
    func fetchAll() async throws -> [Book]
}
