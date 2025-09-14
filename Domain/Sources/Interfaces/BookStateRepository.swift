//
//  BookStateRepository.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

/// 책의 상태 정보를 관리하는 레포지토리 인터페이스
public protocol BookStateRepository {
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// - Parameter seriesOrder: 시리즈 순서 (1-7)
    /// - Returns: 펼침 상태 (true: 펼침, false: 접음)
    func getSummaryExpandState(for seriesOrder: Int) -> Bool
    
    /// 특정 시리즈의 요약 펼침 상태를 저장
    /// - Parameters:
    ///   - seriesOrder: 시리즈 순서 (1-7)
    ///   - isExpanded: 펼침 상태 (true: 펼침, false: 접음)
    func saveSummaryExpandState(for seriesOrder: Int, isExpanded: Bool)
}
