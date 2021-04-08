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
    var isWithdrawOperation = false
    
    // MARK: - Methods
    // MARK: - Public
    func refillCash() {
        isWithdrawOperation = false
        banknoteList = Banknote.Variant.allCases.map { Banknote($0, defaultQuantity) }
        print("ATM was refilled")
    }
    
    func deposit(banknotes depositedBanknotesList: [Banknote]) {
        guard depositedBanknotesList.count > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        var banknotesToDepositList: [Banknote] = []
        var banknoteInfoToPrint: [Banknote] = []
        isWithdrawOperation = false
        
        for banknote in depositedBanknotesList {
            guard let banknoteToUpdate = (banknoteList.first { $0.banknoteVariant == banknote.banknoteVariant }) else {
                continue
            }
            
            banknoteToUpdate.update(quantity: banknoteToUpdate.quantity + banknote.quantity)
            banknotesToDepositList.append(banknoteToUpdate)
            banknoteInfoToPrint.append(banknote)
        }
        
        guard banknotesToDepositList.isEmpty == false else {
            return
        }
        
        updateBanknotesInATM(banknotesToDepositList)
        printQuantityAfterOperation(banknoteInfoToPrint)
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
        
        var sortedBanknotesList: [Banknote] = []
        var requiredBanknotesList: [Banknote] = []
        var banknoteInfoToPrint: [Banknote] = []
        var remainingSum = requestedSum
        isWithdrawOperation = true
        
        if requiresSmallBanknotes{
            sortedBanknotesList = sortedSmallBanknotesDescending()
        } else {
            sortedBanknotesList = sortedBanknotesDescending()
        }
        
        for banknote in sortedBanknotesList {
            guard let banknoteToUpdate = (banknoteList.first { $0.banknoteVariant == banknote.banknoteVariant }),
                  banknote.banknoteValue() <= remainingSum else {
                continue
            }
            
            let banknote = availableBanknoteToWithdraw(banknoteInATM: banknote, remainingSum: remainingSum)
            remainingSum = remainingSum - (banknote.quantity * banknote.banknoteValue())
            
            banknoteToUpdate.update(quantity: banknoteToUpdate.quantity - banknote.quantity)
            
            requiredBanknotesList.append(banknoteToUpdate)
            banknoteInfoToPrint.append(banknote)
        }
        
        guard requiredBanknotesList.isEmpty == false else {
            return
        }
        updateBanknotesInATM(requiredBanknotesList)
        printQuantityAfterOperation(banknoteInfoToPrint)
    }
    
    // MARK: - Private
    private func updateBanknotesInATM(_ list: [Banknote]) {
        for banknote in banknoteList {
            guard let requiredBanknote = (list.first { $0.banknoteVariant == banknote.banknoteVariant }) else {
                continue
            }
            
            banknote.update(quantity: requiredBanknote.quantity)
        }
    }
    
    private func availableBanknoteToWithdraw(banknoteInATM: Banknote, remainingSum: Int) -> Banknote {
        let banknoteQuantity = (remainingSum / (banknoteInATM.banknoteValue()))
        
        guard banknoteInATM.quantity >= banknoteQuantity else {
            return banknoteInATM
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
    
    private func printQuantityAfterOperation(_ banknoteList: [Banknote]){
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
