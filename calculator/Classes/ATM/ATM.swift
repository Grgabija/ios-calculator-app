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
    var banknotes = [
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
        let resetValue = 20
        
        banknotes.forEach { $0.update(quantity: resetValue) }
        print("ATM was refilled")
    }
    
    func withdraw(requestedSum: Int) {
        guard requestedSum > 0, requestedSum % 5 == 0 else {
            print("Error! Requested sum is not valid")
            return
        }
        
        var remainingSum = requestedSum
        var requiredBanknotesList: [Banknote.BanknoteType:Int] = [:]
        var newQuantity = 0
        
        banknotes.sort(by: {$0.banknoteType.rawValue > $1.banknoteType.rawValue})
        
        for banknote in banknotes {
            requiredBanknotesList[banknote.banknoteType] = (remainingSum / (banknote.banknoteType.rawValue))
            remainingSum = (remainingSum % (banknote.banknoteType.rawValue))
            
            if ((requiredBanknotesList[banknote.banknoteType] ?? 0) <= banknote.quantity){
                
                newQuantity = banknote.quantity - (requiredBanknotesList[banknote.banknoteType] ?? 0)
                
                if ((requiredBanknotesList[banknote.banknoteType] ?? 0) > 0) {
                    banknote.update(quantity: newQuantity)
                    print("Withdrawn: \(banknote.banknoteType.rawValue): \(requiredBanknotesList[banknote.banknoteType] ?? 0)")
                }
                
            } else {
                print("Error! Not enough banknotes left for the requested sum")
            }
        }
        
        //FIXME: delete after implementation
        //Prefer small banknotes
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

