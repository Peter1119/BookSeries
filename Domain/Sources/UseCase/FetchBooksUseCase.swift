//
//  FetchBooksUseCase.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public protocol FetchBooksUseCase {
    func fetchBooks() async throws -> [Book]
}

public struct FetchBooks: FetchBooksUseCase {
    private let repository: BooksRepository
    
    public init(repository: BooksRepository) {
        self.repository = repository
    }
    
    public func fetchBooks() async throws -> [Book] {
        return try await repository.fetchAll()
    }
}
