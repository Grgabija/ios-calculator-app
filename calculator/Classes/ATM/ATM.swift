//
//  ATM.swift
//  calculator
//
//  Created by Gabija on 2021-03-22.
//

import Foundation
import UIKit

class ATM {

    // MARK: - Constants
    let defaultQuantity = 20

    // MARK: - Declarations
    var banknotes: [Banknote] = []
    
    // MARK: - Methods
    func refillCash() {
        banknotes.forEach { $0.update(quantity: defaultQuantity) }
        print("ATM was refilled")
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0 else {
            print("Error! Requested sum is not valid")
            return
        }

        guard banknotes.isEmpty == false else {
            print("Error! ATM is empty")
            return
        }

        var remainingSum = requestedSum
        var requiredBanknotes: [Banknote] = []
        var newQuantity = 0
        
//        banknotes.sort(by: {$0.banknoteType.rawValue > $1.banknoteType.rawValue})
//
//        for banknote in banknotes {
//            requiredBanknotesList[banknote.banknoteType] = (remainingSum / (banknote.banknoteType.rawValue))
//            remainingSum = (remainingSum % (banknote.banknoteType.rawValue))
//
//            if ((requiredBanknotesList[banknote.banknoteType] ?? 0) <= banknote.quantity){
//
//                newQuantity = banknote.quantity - (requiredBanknotesList[banknote.banknoteType] ?? 0)
//
//                if ((requiredBanknotesList[banknote.banknoteType] ?? 0) > 0) {
//                    banknote.update(quantity: newQuantity)
//                    print("Withdrawn: \(banknote.banknoteType.rawValue): \(requiredBanknotesList[banknote.banknoteType] ?? 0)")
//                }
//
//            } else {
//                print("Error! Not enough banknotes left for the requested sum")
//            }
//        }
    }
    
    func deposit(banknotes: [Banknote]) {
        guard banknotes.count > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        for banknote in banknotes {
            
            if (banknote.quantity > 0) {
                let banknoteToUpdate = self.banknotes.first(where: { $0.banknoteType == banknote.banknoteType})
                banknoteToUpdate?.update(quantity: banknoteToUpdate?.quantity ?? 0 + banknote.quantity)
                print("Added to the bank account \(banknote.banknoteType.rawValue): \(banknote.quantity)")
            } else {
                print ("ERROR! wrong banknotes quantity")
                
            }
            
        }
        
    }
}

