//
//  DataLoading.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public protocol DataLoading {
    func loadData(forResource: String, withExtension: String) throws -> Data
}

enum DataLoadingError: Error {
    case fileNotFound
}

public final class LocalFileLoader: DataLoading {
    
    public init() {}
    
    public func loadData(forResource name: String, withExtension ext: String) throws -> Data {
        guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
            throw DataLoadingError.fileNotFound
        }
        return try Data(contentsOf: url)
    }
}
