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
    var banknoteList: [Banknote] = [
        Banknote(.oneHundred,0),
        Banknote(.fifty, 0),
        Banknote(.ten, 0),
        Banknote(.five, 0)]
    
    // MARK: - Methods
    // MARK: - Public
    func refillCash() {
        banknoteList.forEach { $0.update(quantity: defaultQuantity) }
        print("ATM was refilled")
    }
    
    func deposit(banknotes depositedBanknoteList: [Banknote]) {
        guard depositedBanknoteList.isEmpty == false else {
            print ("ERROR! No banknotes inserted")
            return
        }
        
        var updatedATMBanknoteList: [Banknote] = []
        
        for banknote in depositedBanknoteList {
            if let banknoteToUpdate: Banknote = banknoteList.first(where: { $0.banknoteVariant == banknote.banknoteVariant }) {
                let newQuantity = banknoteToUpdate.quantity + banknote.quantity
                let newBanknote = Banknote(banknote.banknoteVariant, newQuantity)
                updatedATMBanknoteList.append(newBanknote)
            } else {
                updatedATMBanknoteList.append(banknote)
            }
        }
        guard updatedATMBanknoteList.isEmpty == false else {
            return
        }
        
        updateBanknotesInATM(updatedATMBanknoteList)
        printBanknoteList(depositedBanknoteList, isWithdrawOperation: false)
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
        
        var sortedBanknoteList: [Banknote] = []
        var updatedATMBanknoteList: [Banknote] = []
        var withdrawnBanknoteList: [Banknote] = []
        var remainingSum = requestedSum
        
        if requiresSmallBanknotes{
            sortedBanknoteList = sortedSmallBanknotesDescending()
        } else {
            sortedBanknoteList = sortedBanknotesDescending()
        }
        
        for banknoteInATM in sortedBanknoteList {
            guard banknoteInATM.banknoteValue() <= remainingSum else {
                continue
            }
            
            guard let banknote = availableBanknoteToWithdraw(banknoteInATM: banknoteInATM, remainingSum: remainingSum) else {
                continue
            }
            
            remainingSum = remainingSum - (banknote.quantity * banknote.banknoteValue())
            
            let newQuantity = banknoteInATM.quantity - banknote.quantity
            let newBanknote = Banknote(banknote.banknoteVariant, newQuantity)
            
            updatedATMBanknoteList.append(newBanknote)
            withdrawnBanknoteList.append(banknote)
        }
        
        guard updatedATMBanknoteList.isEmpty == false, remainingSum == 0 else {
            return
        }
        
        updateBanknotesInATM(updatedATMBanknoteList)
        printBanknoteList(withdrawnBanknoteList, isWithdrawOperation: true)
    }
    
    // MARK: - Private
    private func updateBanknotesInATM(_ list: [Banknote]) {
        for banknote in list {
            guard let requiredBanknote: Banknote = banknoteList.first(where: { $0.banknoteVariant == banknote.banknoteVariant }) else {
                banknoteList.append(banknote)
                return
            }
            
            if banknote.quantity == 0 {
                banknoteList.removeAll(where: {$0.banknoteVariant == banknote.banknoteVariant} )
            } else {
                requiredBanknote.update(quantity: banknote.quantity)
            }
        }
    }
    
    private func availableBanknoteToWithdraw(banknoteInATM: Banknote, remainingSum: Int) -> Banknote? {
        let banknoteQuantity = (remainingSum / (banknoteInATM.banknoteValue()))
        
        if banknoteQuantity == 0 {
            return nil
        } else if banknoteInATM.quantity >= banknoteQuantity {
            return Banknote(banknoteInATM.banknoteVariant, banknoteQuantity)
        } else {
            return Banknote(banknoteInATM.banknoteVariant, banknoteInATM.quantity)
        }
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
    
    private func printBanknoteList(_ banknoteList: [Banknote], isWithdrawOperation: Bool) {
        guard banknoteList.isEmpty == false else {
            return
        }
        for banknote in banknoteList {
            guard banknote.quantity > 0 else {
                continue
            }
            
            if isWithdrawOperation {
                print("Withdrawn \(banknote.banknoteValue())€: \(banknote.quantity)")
            } else {
                print("Deposited \(banknote.banknoteValue())€: \(banknote.quantity)")
            }
        }}
}
