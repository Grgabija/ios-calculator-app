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
        banknoteList = Banknote.Variant.allCases.map { Banknote($0, defaultQuantity) }
        print("ATM was refilled")
    }
    
    func deposit(banknotes depositedBanknotesList: [Banknote]) {
        guard depositedBanknotesList.isEmpty == false else {
            print ("ERROR! No banknotes inserted")
            return
        }
        
        var updatedATMBanknoteList: [Banknote] = []
        var depositedBanknoteList: [Banknote] = []
        
        for banknote in depositedBanknotesList {
            guard let banknoteToUpdate = (banknoteList.first { $0.banknoteVariant == banknote.banknoteVariant }) else {
                return
            }
            
            let newQuantity = banknoteToUpdate.quantity + banknote.quantity
            let newBanknote = Banknote(banknote.banknoteVariant, newQuantity)
            updatedATMBanknoteList.append(newBanknote)
            depositedBanknoteList.append(banknote)
        }
        
        guard updatedATMBanknoteList.isEmpty == false else {
            return
        }
        
        updateBanknotesInATM(updatedATMBanknoteList)
        printBanknoteListAfterATMOperation(depositedBanknoteList, isWithdrawOperation: false)
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
        var requiredBanknoteList: [Banknote] = []
        var withdrawnBanknoteList: [Banknote] = []
        var remainingSum = requestedSum
        
        if requiresSmallBanknotes{
            sortedBanknoteList = sortedSmallBanknotesDescending()
        } else {
            sortedBanknoteList = sortedBanknotesDescending()
        }
        
        for banknote in sortedBanknoteList {
            guard let banknoteToUpdate = (banknoteList.first { $0.banknoteVariant == banknote.banknoteVariant }),
                  banknote.banknoteValue() <= remainingSum else {
                continue
            }
            
            let banknote = availableBanknoteToWithdraw(banknoteInATM: banknote, remainingSum: remainingSum)
            remainingSum = remainingSum - (banknote.quantity * banknote.banknoteValue())
            
            let newQuantity = banknoteToUpdate.quantity - banknote.quantity
            let newBanknote = Banknote(banknote.banknoteVariant, newQuantity)
            
            requiredBanknoteList.append(newBanknote)
            withdrawnBanknoteList.append(banknote)
        }
        
        guard requiredBanknoteList.isEmpty == false else {
            return
        }
        updateBanknotesInATM(requiredBanknoteList)
        printBanknoteListAfterATMOperation(withdrawnBanknoteList, isWithdrawOperation: true)
    }
    
    // MARK: - Private
    private func updateBanknotesInATM(_ list: [Banknote]) {
        for banknote in banknoteList {
            guard let requiredBanknote = (list.first { $0.banknoteVariant == banknote.banknoteVariant }) else {
                continue
            }
            
            banknote.update(quantity: requiredBanknote.quantity)
            print("\(banknote.banknoteVariant): \(banknote.quantity)")
        }
    }
    
    private func availableBanknoteToWithdraw(banknoteInATM: Banknote, remainingSum: Int) -> Banknote {
        let banknoteQuantity = (remainingSum / (banknoteInATM.banknoteValue()))
        
        guard banknoteInATM.quantity >= banknoteQuantity else {
            let banknoteInATMQuantity = banknoteInATM.quantity
            let newATMBanknote = Banknote(banknoteInATM.banknoteVariant, banknoteInATMQuantity)
            
            return newATMBanknote
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
    
    private func printBanknoteListAfterATMOperation(_ banknoteList: [Banknote], isWithdrawOperation: Bool){
        guard banknoteList.isEmpty == false else {
            return
        }
        for banknote in banknoteList {
            guard banknote.quantity >= 0 else {
                continue
            }
            
            if isWithdrawOperation {
                print("Withdrawn \(banknote.banknoteValue())€: \(banknote.quantity)")
            } else {
                print("Deposited \(banknote.banknoteValue())€: \(banknote.quantity)")
            }
        }}
}
