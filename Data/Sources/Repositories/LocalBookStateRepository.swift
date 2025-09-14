//
//  LocalBookStateRepository.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation
import Domain

/// UserDefaults를 사용한 책 상태 로컬 저장소
public final class LocalBookStateRepository: BookStateRepository {
    private let userDefaults: UserDefaults
    private let keyPrefix = "SummaryExpanded_Series_"
    
    /// 초기화
    /// - Parameter userDefaults: UserDefaults 인스턴스 (기본값: .standard)
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// - Parameter seriesOrder: 시리즈 순서 (1-7)
    /// - Returns: 펼침 상태 (기본값: false)
    public func getSummaryExpandState(for seriesOrder: Int) -> Bool {
        let key = keyPrefix + String(seriesOrder)
        return userDefaults.bool(forKey: key)
    }
    
    /// 특정 시리즈의 요약 펼침 상태를 저장
    /// - Parameters:
    ///   - seriesOrder: 시리즈 순서 (1-7)
    ///   - isExpanded: 펼침 상태 (true: 펼침, false: 접음)
    public func saveSummaryExpandState(for seriesOrder: Int, isExpanded: Bool) {
        let key = keyPrefix + String(seriesOrder)
        userDefaults.set(isExpanded, forKey: key)
        
        // 즉시 디스크에 저장
        userDefaults.synchronize()
    }
}
