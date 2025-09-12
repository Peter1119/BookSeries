//
//  Book.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public struct Book {
    public let title: String
    public let author: String
    public let pages: Int
    public let releaseDate: String
    public let dedication: String
    public let summary: String
    public let wiki: String
    public let chapters: [Chapter]
}

public struct Chapter {
    let title: String
}
