//
//  BookSeriesDTO.swift
//  Data
//
//  Created by 홍석현 on 9/12/25.
//

import Foundation

public struct BookSeriesDTO: Decodable {
    let data: [BookDTO]
}

public struct BookDTO: Decodable {
    let attributes: BookAttributes
}

public struct BookAttributes: Decodable {
    struct ChapterDTO: Decodable {
        let title: String
    }

    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [ChapterDTO]
}
