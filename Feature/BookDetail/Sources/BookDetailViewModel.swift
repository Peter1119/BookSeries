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
    private var bookModels: IdentifiedArray<BookDetailModel> = .init()
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
        return bookModels.asArray
    }
    
    public func getCurrentModel() -> BookDetailModel? {
        guard let currentOrder = currentSeriesOrder else { return bookModels.first }
        return bookModels[id: currentOrder]
    }
    
    public func getModel(
        by seriesOrder: Int
    ) -> BookDetailModel? {
        return bookModels[id: seriesOrder]
    }
    
    public func selectModel(
        by seriesOrder: Int
    ) {
        if bookModels.asArray.contains(where: { $0.seriesOrder == seriesOrder }) {
            currentSeriesOrder = seriesOrder
        }
    }
    
    public func fetchBooks() async throws -> [BookDetailModel] {
        var result: IdentifiedArray<BookDetailModel> = .init()
        let books = try await fetchBookUseCase?.execute() ?? []
        try await withThrowingTaskGroup(of: BookDetailModel.self) { group in
            for (offset, element) in books.enumerated() {
                group.addTask {
                    let index = offset + 1
                    let isExpanded = await self.getSummaryExpandState(for: index)
                    return BookDetailModel(
                        seriesOrder: index,
                        book: element,
                        isSummaryExpanded: isExpanded
                    )
                }
            }
            
            for try await data in group {
                result[id: data.id] = data
            }
        }
        result.sort(by: { $0.seriesOrder < $1.seriesOrder })
        self.bookModels = result
        return self.bookModels.asArray
    }
    
    // MARK: - State Management
    
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// - Parameter seriesOrder: 시리즈 순서 (1-7)
    /// - Returns: 펼침 상태 (true: 펼침, false: 접음)
    private func getSummaryExpandState(
        for seriesOrder: Int
    ) async -> Bool {
        return await manageBookStateUseCase?.getSummaryExpandState(for: seriesOrder) ?? false
    }

    /// 특정 시리즈의 요약 펼침 상태를 설정
    /// - Parameters:
    ///   - seriesOrder: 시리즈 순서 (1-7)
    ///   - isExpanded: 설정할 펼침 상태
    public func setSummaryExpandState(
        for seriesOrder: Int,
        isExpanded: Bool
    ) {
        Task {
            self.bookModels[id: seriesOrder]?.isSummaryExpanded = isExpanded
            print("펼치기 상태 변경 시도 \(seriesOrder): \(isExpanded)")
            await manageBookStateUseCase?.setSummaryExpandState(
                for: seriesOrder,
                isExpanded: isExpanded
            )
        }
    }
}
