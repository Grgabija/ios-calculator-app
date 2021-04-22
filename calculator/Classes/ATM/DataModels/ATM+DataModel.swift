//
//  ATM+DataModel.swift
//  calculator
//
//  Created by Gabija on 2021-03-22.
//

import Foundation
import UIKit

class ATMDataModel {
    
    // MARK: - Declarations
    var banknoteList: [Banknote] = []
    
    // MARK: - Methods
    // MARK: - Public
    func refillCash(refillBanknoteList: [Banknote]) {
        guard refillBanknoteList.isEmpty == false else {
            return
        }
        
        banknoteList.removeAll()
        banknoteList.append(contentsOf: refillBanknoteList)
        print("ATM was refilled")
    }
    
    func deposit(banknotes depositedBanknoteList: [Banknote]) {
        guard depositedBanknoteList.isEmpty == false else {
            print ("ERROR! No banknotes inserted")
            return
        }
        
        var updatedATMBanknoteList: [Banknote] = []
        
        for banknote in depositedBanknoteList {
            if let banknoteToUpdate: Banknote = banknoteList.banknote(banknote) {
                let newQuantity = banknoteToUpdate.quantity + banknote.quantity
                let newBanknote = Banknote(banknote.banknoteVariant, quantity: newQuantity)
                updatedATMBanknoteList.append(newBanknote)
            } else {
                updatedATMBanknoteList.append(banknote)
            }
        }
        guard updatedATMBanknoteList.isEmpty == false else {
            return
        }
        
        updateBanknotesInATM(list: updatedATMBanknoteList)
        printBanknoteList(banknoteList: depositedBanknoteList, isWithdrawOperation: false)
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
            let newBanknote = Banknote(banknote.banknoteVariant, quantity: newQuantity)
            
            updatedATMBanknoteList.append(newBanknote)
            withdrawnBanknoteList.append(banknote)
        }
        
        guard updatedATMBanknoteList.isEmpty == false, remainingSum == 0 else {
            return
        }
        
        updateBanknotesInATM(list: updatedATMBanknoteList)
        printBanknoteList(banknoteList: withdrawnBanknoteList, isWithdrawOperation: true)
    }
    
    // MARK: - Private
    private func updateBanknotesInATM(list: [Banknote]) {
        guard list.isEmpty == false else {
            return
        }
        
        for banknote in list {
            guard banknote.quantity >= 0 else {
                return
            }
            
            if let requiredBanknote: Banknote = (banknoteList.banknote(banknote)) {
                requiredBanknote.update(quantity: banknote.quantity)
                removeIfNecessary(banknote)
            } else {
                banknoteList.append(banknote)
            }
        }
    }
    
    private func availableBanknoteToWithdraw(banknoteInATM: Banknote, remainingSum: Int) -> Banknote? {
        guard remainingSum >= 0, banknoteInATM.quantity >= 0 else {
            return nil
        }
        
        let banknoteQuantity = (remainingSum / (banknoteInATM.banknoteValue()))
        
        guard banknoteQuantity != 0 else {
            return nil
        }
        
        if banknoteInATM.quantity >= banknoteQuantity {
            return Banknote(banknoteInATM.banknoteVariant, quantity: banknoteQuantity)
        } else {
            return Banknote(banknoteInATM.banknoteVariant, quantity: banknoteInATM.quantity)
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
    
    private func printBanknoteList(banknoteList: [Banknote], isWithdrawOperation: Bool) {
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
        }
    }
    
    private func removeIfNecessary(_ banknote: Banknote) {
        if banknote.quantity == 0 {
            banknoteList.remove(banknote)
        }
    }
}
