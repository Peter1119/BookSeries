//
//  BookDetailViewModel.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/11/25.
//

import Foundation
import Domain

public final class BookDetailViewModel {
    private let fetchBookUseCase: FetchBooksUseCase?
    private var bookModels: [BookDetailModel] = []
    private var currentModelId: UUID?
    
    public init(fetchBookUseCase: FetchBooksUseCase? = nil) {
        self.fetchBookUseCase = fetchBookUseCase
    }
    
    // MARK: - BookDetailModel Management
    public func getAllBookModels() -> [BookDetailModel] {
        return bookModels
    }
    
    public func getCurrentModel() -> BookDetailModel? {
        guard let currentId = currentModelId else { return bookModels.first }
        return bookModels.first { $0.id == currentId }
    }
    
    public func getModel(by id: UUID) -> BookDetailModel? {
        return bookModels.first { $0.id == id }
    }
    
    public func selectModel(by id: UUID) {
        if bookModels.contains(where: { $0.id == id }) {
            currentModelId = id
        }
    }
    
    // MARK: - Future Implementation
    public func fetchBooks() async throws -> [BookDetailModel] {
        let books = try await fetchBookUseCase?.execute() ?? []
        self.bookModels = books.enumerated().map { offset, element in
            return BookDetailModel(seriesOrder: offset + 1, book: element)
        }
        return self.bookModels
    }
}
