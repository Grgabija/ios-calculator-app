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
    var banknoteList: [Banknote] = []
    
    // MARK: - Methods
    // MARK: - Public
    func refillCash() {
        banknoteList = Banknote.TypeOfBanknote.allCases.map { Banknote($0, defaultQuantity) }
        print("ATM was refilled")
    }
    
    func deposit(banknotes banknoteList: [Banknote]) {
        guard banknoteList.count > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        for banknote in banknoteList {
            updateBanknoteQuantity(banknote)
        }
    }
    
    func withdraw(requestedSum: Int, requiresSmallBanknotes: Bool) {
        guard requestedSum > 0, requestedSum % 5 == 0 else {
            print("Error! Requested sum is not valid")
            return
        }
        
        guard banknoteList.isEmpty == false else {
            print("Error! ATM is empty")
            return
        }
        
        var requiredBanknoteList: [Banknote] = []
        let sortedBanknotesList: [Banknote]
        var remainingSum = requestedSum
        
        if requiresSmallBanknotes{
            sortedBanknotesList = sortedSmallBanknotesDescending()
        } else {
            sortedBanknotesList = sortedBanknotesDescending()
        }
        
        for banknote in sortedBanknotesList {
            let banknote = calculateRequiredBanknote(banknoteInATM: banknote, remainingSum: remainingSum)
            remainingSum = remainingSum - (banknote.quantity * banknote.banknoteValue())
            requiredBanknoteList.append(banknote)
        }
    }
    
    // MARK: - Private
    private func updateBanknoteQuantity(_ banknote: Banknote) {
        guard let banknoteToUpdate = (self.banknoteList.first { $0.banknoteVariant == banknote.banknoteVariant }),
              banknote.quantity > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        banknoteToUpdate.update(quantity: banknoteToUpdate.quantity + banknote.quantity)
        print("Added to the bank account \(banknote.banknoteValue()): \(banknote.quantity)")
    }
    
    private func calculateRequiredBanknote(banknoteInATM: Banknote, remainingSum: Int) -> Banknote {
        let banknoteQuantity = (remainingSum / (banknoteInATM.banknoteValue()))
        let newBanknoteQuantity = banknoteInATM.quantity - banknoteQuantity
        
        if banknoteInATM.quantity > banknoteQuantity { //i cant get required for withdraval banknotes quantity earlier than this point
            if banknoteQuantity > 0 { //same with here, but just for omitting "x type banknote: 0" prints
                banknoteInATM.update(quantity: newBanknoteQuantity)
                print("Withdrawn: \(banknoteInATM.banknoteValue()): \(banknoteQuantity)")
            }
        } else {
            print("Error! Not enough banknotes left for the requested sum")
        }
        
        return Banknote(banknoteInATM.banknoteVariant, banknoteQuantity)
    }
    
    // MARK: - Helpers
    private func sortedBanknotesDescending() -> [Banknote] {
        return banknoteList.sorted{ $0.banknoteValue() > $1.banknoteValue() }
    }
    
    private func sortedSmallBanknotesDescending() -> [Banknote] {
        var smallBanknotes = banknoteList.filter{ $0.isSmallBanknote() }
        smallBanknotes.sort{ $0.banknoteValue() > $1.banknoteValue() }
        
        return smallBanknotes
    }
}
