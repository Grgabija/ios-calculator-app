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
    
    private var banknotesQuantity: Dictionary<EuroBanknote,Int> = [:]
    private var previousBanknotesQuantity = 0
    private var quantityToRefill = 0
    private var remainder = 0
    private var requiredBanknotesQuantity: Dictionary<EuroBanknote,Int> = [:]
    
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
        for banknote in sortedBanknotesDescending {
            switch banknote {
            case .fiveHundred:
                guard banknotesQuantity[.fiveHundred] != 0, requestedSum >= banknote.rawValue, banknotesQuantity[.fiveHundred] != nil else {
                    remainder = requestedSum
                    continue
                }
                requiredBanknotesQuantity[.fiveHundred] = (requestedSum / (banknote.rawValue))
                remainder = (requestedSum % (banknote.rawValue))
                banknotesQuantity[.fiveHundred] = (banknotesQuantity[.fiveHundred] ?? 0) - (requiredBanknotesQuantity[.fiveHundred] ?? 0)
                continue
                
            case .twoHundred:
                guard banknotesQuantity[.twoHundred] != 0, remainder >= banknote.rawValue, banknotesQuantity[.twoHundred] != nil else {
                    continue
                }
                requiredBanknotesQuantity[.twoHundred] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.twoHundred] = (banknotesQuantity[.twoHundred] ?? 0) - (requiredBanknotesQuantity[.twoHundred] ?? 0)
                continue
                
            case .oneHundred:
                guard banknotesQuantity[.oneHundred] != 0, remainder >= banknote.rawValue, banknotesQuantity[.oneHundred] != nil else {
                    continue
                }
                requiredBanknotesQuantity[.oneHundred] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.oneHundred] = (banknotesQuantity[.oneHundred] ?? 0) - (requiredBanknotesQuantity[.oneHundred] ?? 0)
                continue
                
            case .fifty:
                guard banknotesQuantity[.fifty] != 0, remainder >= banknote.rawValue, banknotesQuantity[.fifty] != nil else {
                    continue
                }
                requiredBanknotesQuantity[.fifty] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.fifty] = (banknotesQuantity[.fifty] ?? 0) - (requiredBanknotesQuantity[.fifty] ?? 0)
                continue
                
            case .twenty:
                guard banknotesQuantity[.twenty] != 0, remainder >= banknote.rawValue, banknotesQuantity[.twenty] != nil else {
                    continue
                }
                requiredBanknotesQuantity[.twenty] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.twenty] = (banknotesQuantity[.twenty] ?? 0) - (requiredBanknotesQuantity[.twenty] ?? 0)
                continue
                
            case .ten:
                guard banknotesQuantity[.ten] != 0, remainder >= banknote.rawValue, banknotesQuantity[.ten] != nil else {
                    continue
                }
                requiredBanknotesQuantity[.ten] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.ten] = (banknotesQuantity[.ten] ?? 0) - (requiredBanknotesQuantity[.ten] ?? 0)
                continue
                
            case .five:
                guard banknotesQuantity[.five] != 0, remainder >= banknote.rawValue, banknotesQuantity[.five] != nil else {
                    break
                }
                requiredBanknotesQuantity[.five] = (remainder / (banknote.rawValue))
                remainder = (remainder % (banknote.rawValue))
                banknotesQuantity[.five] = (banknotesQuantity[.five] ?? 0) - (requiredBanknotesQuantity[.five] ?? 0)
                break
            }
            break
        }
        
        for (banknoteValue, quantity) in requiredBanknotesQuantity.sorted(by: {$0.key.rawValue > $1.key.rawValue}) {
            print("\(banknoteValue.rawValue): \(quantity)")
            
        }
        //FIXME: delete after implementation
        //get reoccuring cases into private method
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

