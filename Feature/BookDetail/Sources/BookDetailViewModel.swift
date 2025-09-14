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
    
    // Mock 데이터용 초기화
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
    public func fetchBooks() async throws -> [Book] {
        return try await fetchBookUseCase?.execute() ?? []
    }
}
