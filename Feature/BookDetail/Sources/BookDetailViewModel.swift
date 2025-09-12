//
//  BookDetailViewModel.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/11/25.
//

import Foundation
import Domain

public class BookDetailViewModel {
    private let fetchBookUseCase: FetchBooksUseCase?
    private var bookModels: [BookDetailModel] = []
    private var currentModelId: UUID?
    
    // Mock 데이터용 초기화
    public init(fetchBookUseCase: FetchBooksUseCase? = nil) {
        self.fetchBookUseCase = fetchBookUseCase
        setupMockModels()
    }
    
    private func setupMockModels() {
        bookModels = mockBooks.enumerated().map { index, book in
            BookDetailModel(seriesOrder: index + 1, book: book)
        }
        currentModelId = bookModels.first?.id
    }
    
    // MARK: - Mock Data
    private let mockBooks: [Book] = [
        // 1권
        Book(
            title: "Harry Potter and the Philosopher's Stone",
            author: "J. K. Rowling",
            pages: 223,
            releaseDate: "1997-06-26",
            dedication: "For Jessica, who loves stories, for Anne, who loved them too, and for Di, who heard this one first",
            summary: "Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher's_Stone",
            chapters: [
                Chapter(title: "1. The Boy Who Lived"),
                Chapter(title: "2. The Vanishing Glass"),
                Chapter(title: "3. The Letter from No One"),
                Chapter(title: "4. The Keeper of the Keys"),
                Chapter(title: "5. Diagon Alley"),
                Chapter(title: "1. The Boy Who Lived"),
                Chapter(title: "2. The Vanishing Glass"),
                Chapter(title: "3. The Letter from No One"),
                Chapter(title: "4. The Keeper of the Keys"),
                Chapter(title: "5. Diagon Alley"),
                Chapter(title: "1. The Boy Who Lived"),
                Chapter(title: "2. The Vanishing Glass"),
                Chapter(title: "3. The Letter from No One"),
                Chapter(title: "4. The Keeper of the Keys"),
                Chapter(title: "5. Diagon Alley")
            ]
        ),
        // 2권
        Book(
            title: "Harry Potter and the Chamber of Secrets",
            author: "J. K. Rowling",
            pages: 251,
            releaseDate: "1998-07-02",
            dedication: "For Séan P. F. Harris, getaway driver and foul-weather friend",
            summary: "Harry Potter's summer has included the worst birthday ever, doomy warnings from a house-elf called Dobby.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Chamber_of_Secrets",
            chapters: [
                Chapter(title: "1. The Worst Birthday"),
                Chapter(title: "2. Dobby's Warning"),
                Chapter(title: "3. The Burrow"),
                Chapter(title: "4. At Flourish and Blotts"),
                Chapter(title: "5. The Whomping Willow")
            ]
        ),
        // 3권
        Book(
            title: "Harry Potter and the Prisoner of Azkaban",
            author: "J. K. Rowling",
            pages: 317,
            releaseDate: "1999-07-08",
            dedication: "To Jill Prewett and Aine Kiely, the Godmothers of Swing",
            summary: "When the Knight Bus crashes through the darkness and screeches to a halt in front of him, it's the start of another far from ordinary year at Hogwarts for Harry Potter.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Prisoner_of_Azkaban",
            chapters: [
                Chapter(title: "1. Owl Post"),
                Chapter(title: "2. Aunt Marge's Big Mistake"),
                Chapter(title: "3. The Knight Bus"),
                Chapter(title: "4. The Leaky Cauldron"),
                Chapter(title: "5. The Dementor")
            ]
        ),
        // 4권
        Book(
            title: "Harry Potter and the Goblet of Fire",
            author: "J. K. Rowling",
            pages: 636,
            releaseDate: "2000-07-08",
            dedication: "To Peter Rowling, in memory of Mr Ridley and to Susan Sladden, who helped Harry out of his cupboard",
            summary: "The Triwizard Tournament is to be held at Hogwarts. Only wizards who are over seventeen are allowed to enter.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Goblet_of_Fire",
            chapters: [
                Chapter(title: "1. The Riddle House"),
                Chapter(title: "2. The Scar"),
                Chapter(title: "3. The Invitation"),
                Chapter(title: "4. Back to The Burrow"),
                Chapter(title: "5. Weasley's Wizard Wheezes")
            ]
        ),
        // 5권
        Book(
            title: "Harry Potter and the Order of the Phoenix",
            author: "J. K. Rowling",
            pages: 766,
            releaseDate: "2003-06-21",
            dedication: "To Neil, Jessica and David, who make my world magical",
            summary: "Dark times have come to Hogwarts. After the Dementors' attack on his cousin Dudley, Harry Potter knows that Voldemort will stop at nothing to find him.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Order_of_the_Phoenix",
            chapters: [
                Chapter(title: "1. Dudley Demented"),
                Chapter(title: "2. A Peck of Owls"),
                Chapter(title: "3. The Advance Guard"),
                Chapter(title: "4. Number Twelve Grimmauld Place"),
                Chapter(title: "5. The Order of the Phoenix")
            ]
        ),
        // 6권
        Book(
            title: "Harry Potter and the Half-Blood Prince",
            author: "J. K. Rowling",
            pages: 607,
            releaseDate: "2005-07-16",
            dedication: "To Mackenzie, My beautiful daughter, I dedicate Her ink-and-paper twin.",
            summary: "When Dumbledore arrives at Privet Drive one summer night to collect Harry Potter, his wand hand is blackened and shrivelled.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Half-Blood_Prince",
            chapters: [
                Chapter(title: "1. The Other Minister"),
                Chapter(title: "2. Spinner's End"),
                Chapter(title: "3. Will and Won't"),
                Chapter(title: "4. Horace Slughorn"),
                Chapter(title: "5. An Excess of Phlegm")
            ]
        ),
        // 7권
        Book(
            title: "Harry Potter and the Deathly Hallows",
            author: "J. K. Rowling",
            pages: 610,
            releaseDate: "2007-07-21",
            dedication: "To Neil, To Jessica, To David, To Kenzie, To Di, To Anne, And to You If you have stuck with Harry until the very end.",
            summary: "As he climbs into the sidecar of Hagrid's motorbike and takes to the skies, leaving Privet Drive for the last time.",
            wiki: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Deathly_Hallows",
            chapters: [
                Chapter(title: "1. The Dark Lord Ascending"),
                Chapter(title: "2. In Memoriam"),
                Chapter(title: "3. The Dursleys Departing"),
                Chapter(title: "4. The Seven Potters"),
                Chapter(title: "5. Fallen Warrior")
            ]
        )
    ]
    
    // MARK: - BookDetailModel Management
    public func getAllBookModels() -> [BookDetailModel] {
        return bookModels
    }
    
    public func getCurrentModel() -> BookDetailModel? {
        guard let currentId = currentModelId else { return bookModels.first }
        return bookModels.first { $0.id == currentId }
    }
    
    public func getModel(by id: UUID) -> BookDetailModel? {
        return bookModels.first { $0.id == id }
    }
    
    public func selectModel(by id: UUID) {
        if bookModels.contains(where: { $0.id == id }) {
            currentModelId = id
        }
    }
    
    // MARK: - Legacy Methods (for backward compatibility)
    public func getBook(at index: Int) -> Book {
        guard index >= 0 && index < mockBooks.count else {
            return mockBooks[0]
        }
        return mockBooks[index]
    }
    
    public func getAllBooks() -> [Book] {
        return mockBooks
    }
    
    // MARK: - Future Implementation
    public func fetchBooks() async throws -> [Book] {
        guard let fetchBookUseCase = fetchBookUseCase else {
            // Mock 데이터 반환
            return getAllBooks()
        }
        
        return try await fetchBookUseCase.execute()
    }
}
