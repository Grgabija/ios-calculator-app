//
//  Banknote.swift
//  calculator
//
//  Created by Gabija on 2021-03-29.
//

import Foundation


class Banknote {
    
    // MARK: - Declarations
    var banknoteType: BanknoteType
    var quantity: Int

    // MARK: - Methods
    init(banknoteType: BanknoteType, quantity: Int) {
        self.banknoteType = banknoteType
        self.quantity = quantity
    }
    
    func update(quantity:Int) {
        self.quantity = quantity
        print("\(banknoteType): \(quantity)")
    }
    
}

enum BanknoteType {
    case fiveHundred,
         twoHundred,
         oneHundred,
         fifty,
         twenty,
         ten,
         five
}
//private var banknotesQuantity: [BanknoteType:Int] =
//    [.fiveHundred: 0,
//     .twoHundred: 0,
//     .oneHundred: 0,
//     .fifty: 0,
//     .twenty: 0,
//     .ten: 0,
//     .five: 0
//    ]
//
//func quantity(){
//    let banknoteQuantity = banknotesQuantity.values.compactMap {Int($0)}
//    print(banknoteQuantity)
//}
