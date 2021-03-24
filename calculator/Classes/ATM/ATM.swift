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
    
    private var banknotesQuantity: [EuroBanknote:Int] = [:]
    private var previousBanknotesQuantity = 0
    private var quantityToRefill = 0
    private var requiredBanknotesQuantity: [EuroBanknote:Int] = [:]
    
    // MARK: - Methods
    func refillCash() {
        previousBanknotesQuantity = banknotesQuantity[.fiveHundred] ?? 0
        quantityToRefill = (20 - previousBanknotesQuantity)
        banknotesQuantity[.fiveHundred] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 500€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.twoHundred] ?? 0
        quantityToRefill = (20 - previousBanknotesQuantity)
        banknotesQuantity[.twoHundred] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 200€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.oneHundred] ?? 0
        quantityToRefill = (40 - previousBanknotesQuantity)
        banknotesQuantity[.oneHundred] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 100€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.fifty] ?? 0
        quantityToRefill = (50 - previousBanknotesQuantity)
        banknotesQuantity[.fifty] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 50€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.twenty] ?? 0
        quantityToRefill = (100 - previousBanknotesQuantity)
        banknotesQuantity[.twenty] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 20€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.ten] ?? 0
        quantityToRefill=(150 - previousBanknotesQuantity)
        banknotesQuantity[.ten] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 10€ banknotes")
        
        previousBanknotesQuantity = banknotesQuantity[.five] ?? 0
        quantityToRefill=(200 - previousBanknotesQuantity)
        banknotesQuantity[.five] = (previousBanknotesQuantity + quantityToRefill)
        print("ATM were refilled with \(quantityToRefill): 5€ banknotes")
        
        //FIXME: delete after implementation
        //make those magic numbers into genericQuantity (enum),
        //after that get reoccuring cases into private method
        //add up to some number 25 000
        //20x 500, 20x 200, 40x 100, 50x 50, 100x 20, 150x 10, 200x 5
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0  else {
            print("Error! Requested sum is not valid")
            return
        }
        
        let sortedBanknotesDescending = banknotesQuantity.keys.sorted(by: {$0.rawValue > $1.rawValue})
        var remainingSum = requestedSum
        
        for banknote in sortedBanknotesDescending {
            guard banknotesQuantity[banknote] != 0, remainingSum >= banknote.rawValue, banknotesQuantity[banknote] != nil else {
                continue
            }
            
            requiredBanknotesQuantity[banknote] = (remainingSum / (banknote.rawValue))
            remainingSum = (requestedSum % (banknote.rawValue))
            banknotesQuantity[banknote] = (banknotesQuantity[banknote] ?? 0) - (requiredBanknotesQuantity[banknote] ?? 0)
        }
        
        for (banknoteValue, quantity) in requiredBanknotesQuantity.sorted(by: {$0.key.rawValue > $1.key.rawValue}) {
            print("\(banknoteValue.rawValue): \(quantity)")
        }
        //FIXME: delete after implementation
        //least amount of banknotes necessary with banknotes that are available
        //aka Prefer small banknotes
    }
    
    func deposit(banknotes: [EuroBanknote]) {
        //TODO: Guard
        //        guard depositBanknotesQuantity > 0, depositBanknotesQuantity <= quantityToRefill else {
        //            print ("ERROR! wrong banknotes quantity: \(depositBanknotesQuantity)")
        //            return
        //        }
        var insertedSum = 0
        for banknoteNumber in banknotes {
            banknotesQuantity[banknoteNumber] = banknotesQuantity[banknoteNumber] ?? 0 + 1
            insertedSum = insertedSum + banknoteNumber.rawValue
        }
        print(insertedSum)
        
        //FIXME: delete after implementation
        //print banknotes quantity and what type of banknotes were added, banknotes sum
        //banknote quantity add to overall atm banknote quantity
    }
}

