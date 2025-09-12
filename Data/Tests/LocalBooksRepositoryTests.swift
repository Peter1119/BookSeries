//
//  LocalBooksRepositoryTests.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Testing
@testable import Data

struct LocalBooksRepositoryTests {
    
    @Test
    func fetchAll_올바른_책의_개수를_반환한다() async throws {
        // Given: 테스트 대상 준비
        let repository = LocalBooksRepository()
        
        // When: 메서드 호출
        let books = try await repository.fetchAll()
        
        // Then: 결과 검증
        #expect(books.count == 2, "반환된 책의 개수는 2여야 합니다.")
        #expect(books[0].title == "Harry Potter and the Philosopher's Stone", "첫 번째 책의 제목이 'Harry Potter and the Philosopher's Stone'여야 합니다.")
    }
}
