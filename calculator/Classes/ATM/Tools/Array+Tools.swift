//
//  Array+Tools.swift
//  calculator
//
//  Created by Gabija on 2021-04-16.
//

import Foundation

extension Array where Element: Banknote {
    
    mutating func remove(_ banknote: Element) {
        if let index = firstIndex(of: banknote){
            remove(at: index)
        }
    }
    
    func banknote(_ banknote: Banknote) -> Banknote? {
        if let banknote = first(where: { $0 == banknote }){
            return banknote
        }
        return nil
    }
}

