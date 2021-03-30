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
    
    private let genericBanknoteQuantity: [BanknoteEnum:Int] = //default or base, same for all banknotes. No upper limit. Only as a starting value.
        [.fiveHundred: 20,
         .twoHundred: 20,
         .oneHundred: 40,
         .fifty: 50,
         .twenty: 100,
         .ten: 150,
         .five: 200
        ] //INFINITE POWER
    
    private var banknotesQuantity: [BanknoteEnum:Int] =
        [.fiveHundred: 0,
         .twoHundred: 0,
         .oneHundred: 0,
         .fifty: 0,
         .twenty: 0,
         .ten: 0,
         .five: 0
        ] //seperate class, holds type and quantity, init for type and quantity and update
    
    var banknotes = [
        Banknote(banknoteType: .five, quantity: 0),
        Banknote(banknoteType: .ten, quantity: 0),
        Banknote(banknoteType: .twenty, quantity: 0),
        Banknote(banknoteType: .fifty, quantity: 0),
        Banknote(banknoteType: .oneHundred, quantity: 0),
        Banknote(banknoteType: .twoHundred, quantity: 0),
        Banknote(banknoteType: .fiveHundred, quantity: 0)
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
    
    func deposit(banknotes: [BanknoteEnum]) {
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

