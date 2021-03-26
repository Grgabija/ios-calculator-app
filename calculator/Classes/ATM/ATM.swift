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
    enum EuroBanknote: Int {
        case fiveHundred = 500,
             twoHundred = 200,
             oneHundred = 100,
             fifty = 50,
             twenty = 20,
             ten = 10,
             five = 5
    }
    
    private let genericBanknoteQuantity: [EuroBanknote:Int] =
        [.fiveHundred: 20,
         .twoHundred: 20,
         .oneHundred: 40,
         .fifty: 50,
         .twenty: 100,
         .ten: 150,
         .five: 200
        ]
    
    private var banknotesQuantity: [EuroBanknote:Int] =
        [.fiveHundred: 0,
         .twoHundred: 0,
         .oneHundred: 0,
         .fifty: 0,
         .twenty: 0,
         .ten: 0,
         .five: 0
        ]
    
    // MARK: - Methods
    func refillCash() {

        var previousBanknotesQuantity = 0
        var quantityToRefill: [EuroBanknote:Int] = [:]
        let sortedBanknotesDescending = sortBanknotesDescending()
        
        for banknote in sortedBanknotesDescending {
            previousBanknotesQuantity = banknotesQuantity[banknote] ?? 0
            quantityToRefill[banknote] = (genericBanknoteQuantity[banknote] ?? 0) - previousBanknotesQuantity
            banknotesQuantity[banknote] = previousBanknotesQuantity + (quantityToRefill[banknote] ?? 0)
            guard (quantityToRefill[banknote] ?? 0) > 0 else {
                continue
            }
            print("ATM were refilled with \(quantityToRefill[banknote] ?? 0): \(banknote.rawValue)€ banknotes")
        }
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0  else {
            print("Error! Requested sum is not valid")
            return
        }
        var remainingSum = requestedSum
        let sortedBanknotesDescending = sortBanknotesDescending()
        var requiredBanknotesQuantity: [EuroBanknote:Int] = [:]
        
        for banknote in sortedBanknotesDescending {
            guard banknotesQuantity[banknote] != 0, remainingSum >= banknote.rawValue, banknotesQuantity[banknote] != nil else {
                continue
            }
            
            requiredBanknotesQuantity[banknote] = (remainingSum / (banknote.rawValue))
            remainingSum = (requestedSum % (banknote.rawValue))
            banknotesQuantity[banknote] = (banknotesQuantity[banknote] ?? 0) - (requiredBanknotesQuantity[banknote] ?? 0)
        }
        
        for (banknoteValue, quantity) in requiredBanknotesQuantity.sorted(by: {$0.key.rawValue > $1.key.rawValue}) {
            print("Withdrawn: \(banknoteValue.rawValue): \(quantity)")
        }
        //FIXME: delete after implementation
        //Prefer small banknotes
    }
    
    private func sortBanknotesDescending() -> Array<EuroBanknote> {
        let sortedBanknotes = banknotesQuantity.keys.sorted(by: {$0.rawValue > $1.rawValue})
        return sortedBanknotes
    }
    
    func deposit(banknotes: [EuroBanknote]) {
        //TODO: By the logic, is this guard needed? Either should it be the error, or should it "add to bank account 0"?
        guard banknotes.count > 0 else {
                    print ("ERROR! wrong banknotes quantity")
                    return
                }
        var insertedSum = 0
        for banknoteNumber in banknotes {
            guard (banknotesQuantity[banknoteNumber] ?? 0) < (genericBanknoteQuantity[banknoteNumber] ?? 0) else {
                print("There is not enough space in ATM to deposit")
                return
            }
            banknotesQuantity[banknoteNumber] = (banknotesQuantity[banknoteNumber] ?? 0) + 1
            insertedSum = insertedSum + banknoteNumber.rawValue
        }
        print("Added to the bank account \(insertedSum)€")
    }
}

