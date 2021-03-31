//
//  Banknote.swift
//  calculator
//
//  Created by Gabija on 2021-03-29.
//

import Foundation


class Banknote {
    
    // MARK: - Declarations
    enum BanknoteType: Int {
        case five = 5,
             ten = 10,
             twenty = 20,
             fifty = 50,
             oneHundred = 100,
             twoHundred = 200,
             fiveHundred = 500
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
    }
    
}
