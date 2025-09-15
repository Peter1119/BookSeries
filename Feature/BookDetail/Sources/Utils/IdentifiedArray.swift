//
//  IdentifiedArray.swift
//  BookDetailFeature
//
//  Created by 홍석현 on 9/14/25.
//

import Foundation

public struct IdentifiedArray<Element: Identifiable> {
    
    private var elements: [Element]
    private var lookup: [Element.ID: Int] // ID를 키로, Array의 인덱스를 값으로 저장

    public init() {
        self.elements = []
        self.lookup = [:]
    }
    
    /// ID를 사용해 요소를 가져오거나 수정합니다.
    public subscript(id id: Element.ID) -> Element? {
        get {
            guard let index = lookup[id] else { return nil }
            return elements[index]
        }
        set {
            if let index = lookup[id], let newValue = newValue {
                // 기존 요소 수정
                elements[index] = newValue
            } else if let newValue = newValue {
                // 새 요소 추가
                elements.append(newValue)
                lookup[newValue.id] = elements.count - 1
            } else if let index = lookup[id] {
                // 요소 제거
                elements.remove(at: index)
                lookup.removeValue(forKey: id)
            }
        }
    }
    
    public mutating func append(_ newElement: Element) {
        self[id: newElement.id] = newElement
    }
    
    /// ID를 통해 요소를 제거합니다.
    @discardableResult
    public mutating func remove(id: Element.ID) -> Element? {
        guard let index = lookup[id] else { return nil }
        
        let removedElement = self.elements.remove(at: index)
        self.lookup.removeValue(forKey: id)
        
        for i in index..<self.elements.count {
            self.lookup[self.elements[i].id] = i
        }
        
        return removedElement
    }
    
    /// 여러 요소를 한 번에 추가합니다.
    public mutating func append(contentsOf newElements: [Element]) {
        for element in newElements {
            self.append(element)
        }
    }
    
    /// 현재 저장된 요소들을 배열로 반환합니다.
    public var asArray: [Element] {
        return elements
    }
    
    public var first: Element? {
        return elements.first
    }
    
    public mutating func sort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        elements.sort(by: areInIncreasingOrder)
        
        // 배열의 순서가 변경되었으므로 lookup 딕셔너리 업데이트
        for (index, element) in elements.enumerated() {
            lookup[element.id] = index
        }
    }
}
