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
    private let manageBookStateUseCase: ManageBookStateUseCase?
    private var bookModels: [BookDetailModel] = []
    private var currentSeriesOrder: Int?
    
    /// 초기화
    /// - Parameters:
    ///   - fetchBookUseCase: 책 데이터 조회 유스케이스
    ///   - manageBookStateUseCase: 책 상태 관리 유스케이스
    public init(
        fetchBookUseCase: FetchBooksUseCase? = nil,
        manageBookStateUseCase: ManageBookStateUseCase? = nil
    ) {
        self.fetchBookUseCase = fetchBookUseCase
        self.manageBookStateUseCase = manageBookStateUseCase
    }
    
    // MARK: - BookDetailModel Management
    public func getAllBookModels() -> [BookDetailModel] {
        return bookModels
    }
    
    public func getCurrentModel() -> BookDetailModel? {
        guard let currentOrder = currentSeriesOrder else { return bookModels.first }
        return bookModels.first { $0.seriesOrder == currentOrder }
    }
    
    public func getModel(
        by seriesOrder: Int
    ) -> BookDetailModel? {
        return bookModels.first { $0.seriesOrder == seriesOrder }
    }
    
    public func selectModel(
        by seriesOrder: Int
    ) {
        if bookModels.contains(where: { $0.seriesOrder == seriesOrder }) {
            currentSeriesOrder = seriesOrder
        }
    }
    
    public func fetchBooks() async throws -> [BookDetailModel] {
        let books = try await fetchBookUseCase?.execute() ?? []
        self.bookModels = books.enumerated().map { offset, element in
            let isExpanded = self.getSummaryExpandState(for: offset)
            return BookDetailModel(
                seriesOrder: offset,
                book: element,
                isSummaryExpanded: isExpanded
            )
        }
        return self.bookModels
    }
    
    // MARK: - State Management
    
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// - Parameter seriesOrder: 시리즈 순서 (1-7)
    /// - Returns: 펼침 상태 (true: 펼침, false: 접음)
    private func getSummaryExpandState(
        for seriesOrder: Int
    ) -> Bool {
        return manageBookStateUseCase?.getSummaryExpandState(for: seriesOrder) ?? false
    }

    /// 특정 시리즈의 요약 펼침 상태를 설정
    /// - Parameters:
    ///   - seriesOrder: 시리즈 순서 (1-7)
    ///   - isExpanded: 설정할 펼침 상태
    public func setSummaryExpandState(
        for seriesOrder: Int,
        isExpanded: Bool
    ) {
        self.bookModels[seriesOrder].isSummaryExpanded = isExpanded
        manageBookStateUseCase?.setSummaryExpandState(
            for: seriesOrder,
            isExpanded: isExpanded
        )
    }
}
