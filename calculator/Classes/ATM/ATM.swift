//
//  ATM.swift
//  calculator
//
//  Created by Gabija on 2021-03-22.
//

import Foundation
import UIKit

class ATM {
    
    // MARK: - Declarations
    enum BanknoteEnum: Int {
        case five = 5,
             ten = 10,
             twenty = 20,
             fifty = 50,
             oneHundred = 100,
             twoHundred = 200,
             fiveHundred = 500
    }
    
    private var banknotesQuantity: [BanknoteEnum:Int] =
        [.fiveHundred: 0,
         .twoHundred: 0,
         .oneHundred: 0,
         .fifty: 0,
         .twenty: 0,
         .ten: 0,
         .five: 0
        ] //seperate class, holds type and quantity, init for type and quantity and update
    
    let banknotes = [
        Banknote(.five, 0),
        Banknote(.ten, 0),
        Banknote(.twenty, 0),
        Banknote(.fifty, 0),
        Banknote(.oneHundred, 0),
        Banknote(.twoHundred, 0),
        Banknote(.fiveHundred, 0)
    ]
    
    // MARK: - Methods
    func refillCash() {
        banknotes.forEach { $0.update(quantity: 20) }
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0  else {
            print("Error! Requested sum is not valid")
            return
        }
        
        var remainingSum = requestedSum
        let sortedBanknotesDescending = sortBanknotesDescending()
        var requiredBanknotesList: [BanknoteEnum:Int] = [:]
        
        for banknote in sortedBanknotesDescending {
            guard banknotesQuantity[banknote] != 0, remainingSum >= banknote.rawValue, banknotesQuantity[banknote] != nil else { //with optional values, to check if something is available
                continue
            }
            
            requiredBanknotesList[banknote] = (remainingSum / (banknote.rawValue))
            remainingSum = (requestedSum % (banknote.rawValue))
            banknotesQuantity[banknote] = (banknotesQuantity[banknote] ?? 0) - (requiredBanknotesList[banknote] ?? 0)
        }
        
        for (banknoteValue, quantity) in requiredBanknotesList.sorted(by: {$0.key.rawValue > $1.key.rawValue}) {
            print("Withdrawn: \(banknoteValue.rawValue): \(quantity)")
        }
        //FIXME: delete after implementation
        //Prefer small banknotes
    }
    
    private func sortBanknotesDescending() -> [BanknoteEnum] { //chech where and how many times it is used
        let sortedBanknotes = banknotesQuantity.keys.sorted(by: {$0.rawValue > $1.rawValue})
        return sortedBanknotes
    }
    func deposit(banknotes: [Banknote]) {
        guard banknotes.count > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        for banknote in banknotes {
            let banknoteToUpdate = self.banknotes.first(where: { $0.banknoteType == banknote.banknoteType})
            banknoteToUpdate?.update(quantity: banknoteToUpdate?.quantity ?? 0 + banknote.quantity)
            print("Added to the bank account \(banknote.banknoteType): \(banknote.quantity)")
        }
        
    }
}

