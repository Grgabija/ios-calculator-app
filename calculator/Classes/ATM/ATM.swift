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
    enum Banknote: Int {
        case fiveHundred = 500,
             twoHundred = 200,
             oneHundred = 100,
             fifty = 50,
             twenty = 20,
             ten = 10,
             five = 5
    }
    
    private let genericBanknoteQuantity: [Banknote:Int] = //default or base, same for all banknotes. No upper limit. Only as a starting value.
        [.fiveHundred: 20,
         .twoHundred: 20,
         .oneHundred: 40,
         .fifty: 50,
         .twenty: 100,
         .ten: 150,
         .five: 200
        ] //INFINITE POWER
    
    private var banknotesQuantity: [Banknote:Int] =
        [.fiveHundred: 0,
         .twoHundred: 0,
         .oneHundred: 0,
         .fifty: 0,
         .twenty: 0,
         .ten: 0,
         .five: 0
        ] //seperate class, holds type and quantity, init for type and quantity and update
    
    // MARK: - Methods
    func refillCash() { //reset method
        var previousBanknotesQuantity = 0
        var quantityToRefill: [Banknote:Int] = [:]
        let sortedBanknotesDescending = sortBanknotesDescending()
        //guard early exits only
        for banknote in sortedBanknotesDescending {
            previousBanknotesQuantity = banknotesQuantity[banknote] ?? 0
            quantityToRefill[banknote] = (genericBanknoteQuantity[banknote] ?? 0) - previousBanknotesQuantity
            banknotesQuantity[banknote] = previousBanknotesQuantity + (quantityToRefill[banknote] ?? 0)
            if (quantityToRefill[banknote] ?? 0) > 0 {
                print("ATM were refilled with \(quantityToRefill[banknote] ?? 0): \(banknote.rawValue)€ banknotes")} else {
                    continue
                }
        }
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0  else {
            print("Error! Requested sum is not valid")
            return
        }
        
        var remainingSum = requestedSum
        let sortedBanknotesDescending = sortBanknotesDescending()
        var requiredBanknotesList: [Banknote:Int] = [:]
        
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
    
    private func sortBanknotesDescending() -> [Banknote] { //chech where and how many times it is used
        let sortedBanknotes = banknotesQuantity.keys.sorted(by: {$0.rawValue > $1.rawValue})
        return sortedBanknotes
    }
    
    func deposit(banknotes: [Banknote]) {
        guard banknotes.count > 0 else {
                    print ("ERROR! wrong banknotes quantity")
                    return
                }
        
        var insertedSum = 0
        for banknoteNumber in banknotes {
            banknotesQuantity[banknoteNumber] = (banknotesQuantity[banknoteNumber] ?? 0) + 1
            insertedSum = insertedSum + banknoteNumber.rawValue
        }
        print("Added to the bank account \(insertedSum)€")
    }
}

