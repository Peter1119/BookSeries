//
//  Book.swift
//  Domain
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public struct Book {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
}

public struct Chapter {
    let title: String
}
