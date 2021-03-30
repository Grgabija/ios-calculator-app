//
//  Banknote.swift
//  calculator
//
//  Created by Gabija on 2021-03-29.
//

import Foundation


class Banknote {
    
    // MARK: - Declarations
    enum BanknoteType {
        case fiveHundred,
             twoHundred,
             oneHundred,
             fifty,
             twenty,
             ten,
             five
    }
    
    var banknoteType: BanknoteType
    var quantity: Int
    
    // MARK: - Methods
    init(_ banknoteType: BanknoteType, _ quantity: Int) {
        self.banknoteType = banknoteType
        self.quantity = quantity
    }
    
    func update(quantity:Int) {
        self.quantity = quantity
        print("\(banknoteType): \(quantity)")
    }
    
}
