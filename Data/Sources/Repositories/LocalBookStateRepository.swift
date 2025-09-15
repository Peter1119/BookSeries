//
//  LocalBookStateRepository.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation
import Domain
import SwiftData

/// UserDefaults를 사용한 책 상태 로컬 저장소
public actor LocalBookStateRepository: BookStateRepository {
    private let modelContext: ModelContext
    private let keyPrefix = "SummaryExpanded_Series_"
    
    /// 초기화
    /// - Parameter userDefaults: UserDefaults 인스턴스 (기본값: .standard)
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// 지정된 키에 해당하는 BookState 객체를 가져옵니다.
    private func fetchBookState(for seriesOrder: Int) throws -> BookState? {
        let key = keyPrefix + String(seriesOrder)
        let predicate = #Predicate<BookState> { $0.key == key }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        return try modelContext.fetch(fetchDescriptor).first
    }
    
    // MARK: - Public Interface
    
    /// 특정 시리즈의 요약 펼침 상태를 조회
    /// 데이터가 없을 경우 기본값으로 생성 후 저장합니다.
    public func getSummaryExpandState(
        for seriesOrder: Int
    ) async throws -> Bool {
        if let existingState = try fetchBookState(for: seriesOrder) {
            return existingState.isExpanded
        } else {
            let newState = BookState(key: keyPrefix + String(seriesOrder), isExpanded: false)
            modelContext.insert(newState)
            try modelContext.save()
            return newState.isExpanded
        }
    }
    
    /// 특정 시리즈의 요약 펼침 상태를 저장
    public func saveSummaryExpandState(
        for seriesOrder: Int,
        isExpanded: Bool
    ) async throws {
        if let existingSetting = try fetchBookState(for: seriesOrder) {
            existingSetting.isExpanded = isExpanded
        } else {
            let newSetting = BookState(key: keyPrefix + String(seriesOrder), isExpanded: isExpanded)
            modelContext.insert(newSetting)
        }
        
        // 변경사항을 저장하여 영구화합니다.
        try modelContext.save()
    }
}

