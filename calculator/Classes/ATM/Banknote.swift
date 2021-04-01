//
//  Banknote.swift
//  calculator
//
//  Created by Gabija on 2021-03-29.
//

import Foundation


class Banknote {
    
    // MARK: - Declarations
    enum BanknoteType: Int { // FIXME: adjust naming, now you have double Banknote. Consider separating
        case five = 5
        case ten = 10
        case twenty = 20
        case fifty = 50
        case oneHundred = 100
        case twoHundred = 200
        case fiveHundred = 500
    }
    
    var banknoteType: BanknoteType
    var quantity: Int
    
    // MARK: - Methods
    init(_ banknoteType: BanknoteType, _ quantity: Int) {
        self.banknoteType = banknoteType
        self.quantity = quantity
    }
    
    func update(quantity: Int) {
        self.quantity = quantity
    }
    
    func isSmallBanknote() -> Bool {
        switch banknoteType {
        case .fifty, .oneHundred, .twoHundred, .fiveHundred:
            return false
        case .five, .ten, .twenty:
            return true
        }
    }
}
