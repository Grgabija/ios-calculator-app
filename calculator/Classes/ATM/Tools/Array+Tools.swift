//
//  Array+Tools.swift
//  calculator
//
//  Created by Gabija on 2021-04-16.
//

import Foundation

extension Array where Element: Banknote {
    
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object){
            remove(at: index)
        }
    }
    
    func banknote(object: Element) -> Element? {
        if let banknote = first(where: { $0 == object }){
            return banknote
        }
        return nil
    }
}

