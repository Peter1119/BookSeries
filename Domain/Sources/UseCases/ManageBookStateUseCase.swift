//
//  ManageBookStateUseCase.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public protocol ManageBookStateUseCase {
    func getSummaryExpandState(for seriesOrder: Int) async -> Bool
    func setSummaryExpandState(for seriesOrder: Int, isExpanded: Bool) async
}

/// 책 상태 관리 유스케이스
/// 책의 읽기 상태, UI 상태 등을 관리하는 비즈니스 로직을 담당
public final class ManageBookState: ManageBookStateUseCase {
    private let repository: BookStateRepository
    
    /// 초기화
    /// - Parameter repository: 책 상태 레포지토리
    public init(repository: BookStateRepository) {
        self.repository = repository
    }
    
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// - Parameter seriesOrder: 시리즈 순서 (1-7)
    /// - Returns: 펼침 상태 (true: 펼침, false: 접음)
    public func getSummaryExpandState(for seriesOrder: Int) async -> Bool {
        // 유효한 시리즈 순서인지 검증
        guard isValidSeriesOrder(seriesOrder) else {
            return false // 기본값 반환
        }
        
        let result = try? await repository.getSummaryExpandState(for: seriesOrder)
        return result ?? false
    }

    /// 특정 시리즈의 요약 펼침 상태를 설정
    /// - Parameters:
    ///   - seriesOrder: 시리즈 순서 (1-7)
    ///   - isExpanded: 설정할 펼침 상태
    public func setSummaryExpandState(for seriesOrder: Int, isExpanded: Bool) async {
        // 유효한 시리즈 순서인지 검증
        print(#function, "펼치기 상태 변경 시도 \(seriesOrder): \(isExpanded)")
        guard isValidSeriesOrder(seriesOrder) else {
            return // 잘못된 시리즈 순서면 무시
        }
        
        try? await repository.saveSummaryExpandState(for: seriesOrder, isExpanded: isExpanded)
    }
    
    // MARK: - Private Methods
    
    /// 유효한 시리즈 순서인지 검증 (1-7)
    /// - Parameter seriesOrder: 검증할 시리즈 순서
    /// - Returns: 유효성 여부
    private func isValidSeriesOrder(_ seriesOrder: Int) -> Bool {
        return seriesOrder >= 1 && seriesOrder <= 7
    }
}
