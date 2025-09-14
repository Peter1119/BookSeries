//
//  BookDetailModel.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/12/25.
//

import UIKit
import Domain
import DesignSystem

public struct BookDetailModel {
    let seriesOrder: Int // 1-7
    let book: Book
    var isSummaryExpanded: Bool
    
    public init(
        seriesOrder: Int,
        book: Book,
        isSummaryExpanded: Bool = false
    ) {
        self.seriesOrder = seriesOrder
        self.book = book
        self.isSummaryExpanded = isSummaryExpanded
    }
    
    var image: UIImage {
        switch seriesOrder {
        case 1: return DesignSystemAsset.harrypotter1.image
        case 2: return DesignSystemAsset.harrypotter2.image
        case 3: return DesignSystemAsset.harrypotter3.image
        case 4: return DesignSystemAsset.harrypotter4.image
        case 5: return DesignSystemAsset.harrypotter5.image
        case 6: return DesignSystemAsset.harrypotter6.image
        case 7: return DesignSystemAsset.harrypotter7.image
        default: return DesignSystemAsset.harrypotter1.image
        }
    }
}
