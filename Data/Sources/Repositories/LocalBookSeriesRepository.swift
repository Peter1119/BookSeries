//
//  LocalBookSeriesRepository.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation
import Domain

public struct LocalBookSeriesRepository: BookSeriesRepository {
    public func fetchAll() async throws -> [Domain.Book] {
        return []
    }
}
