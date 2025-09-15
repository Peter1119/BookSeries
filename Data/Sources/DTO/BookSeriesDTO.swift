//
//  BookSeriesDTO.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Domain
import Foundation

public struct BookSeriesDTO: Decodable {
    let data: [BookDTO]
}

public struct BookDTO: Decodable {
    let attributes: BookAttributes
}

public struct BookAttributes: Decodable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [ChapterDTO]
}

public struct ChapterDTO: Decodable {
    let title: String
    
    public func toDomain() -> Chapter {
        return Chapter(title: self.title)
    }
}

extension BookDTO {
    public func toDomain() -> Book {
        return Book(
            title: self.attributes.title,
            author: self.attributes.author,
            pages: self.attributes.pages,
            releaseDate: self.attributes.releaseDate,
            dedication: self.attributes.dedication,
            summary: self.attributes.summary,
            wiki: self.attributes.wiki,
            chapters: self.attributes.chapters.map { $0.toDomain() }
        )
    }
}
