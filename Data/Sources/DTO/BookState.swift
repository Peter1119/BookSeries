//
//  BookState.swift
//  Data
//
//  Created by 홍석현 on 9/14/25.
//

import Foundation
import SwiftData

@Model
final public class BookState {
    var key: String
    var isExpanded: Bool
    
    init(
        key: String,
        isExpanded: Bool
    ) {
        self.key = key
        self.isExpanded = isExpanded
    }
}
