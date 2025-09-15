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

    public init(
        title: String,
        author: String,
        pages: Int,
        releaseDate: String,
        dedication: String,
        summary: String,
        wiki: String,
        chapters: [Chapter]
    ) {
        self.title = title
        self.author = author
        self.pages = pages
        self.releaseDate = releaseDate
        self.dedication = dedication
        self.summary = summary
        self.wiki = wiki
        self.chapters = chapters
    }
}

public struct Chapter {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}
