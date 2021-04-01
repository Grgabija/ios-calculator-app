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
        banknoteList.forEach { $0.update(quantity: defaultQuantity) }
        print("ATM was refilled")
    }
    
    func deposit(banknotes banknoteList: [Banknote]) {
        guard banknoteList.count > 0 else {
            print ("ERROR! wrong banknotes quantity")
            return
        }
        
        for banknote in banknoteList {
            
            if (banknote.quantity > 0) {
                let banknoteToUpdate = self.banknoteList.first{ $0.banknoteType == banknote.banknoteType }
                banknoteToUpdate?.update(quantity: banknoteToUpdate?.quantity ?? 0 + banknote.quantity)
                print("Added to the bank account \(banknote.banknoteType.rawValue): \(banknote.quantity)")
            } else {
                print ("ERROR! wrong banknotes quantity")
                
            }
            
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
        
        let banknotesSorted: [Banknote]
        var remainingSum = requestedSum
        
        if requiresSmallBanknotes{
            banknotesSorted = sortedSmallBanknotes()
        } else {
            banknotesSorted = banknotesSortedDescending()
        }
        
        for banknote in banknotesSorted {
            remainingSum = withdrawLogic(banknote: banknote, remainingSum: remainingSum)
        }
    }
    
    // MARK: - Private
    private func withdrawLogic(banknote: Banknote, remainingSum: Int) -> Int {  //FIXME: naming
        // Naming of a method should be based on what a method does, not information outside of that
        // method. A method has no idea who called it and for what reason
        var requiredBanknoteList: [Banknote] = []
        requiredBanknoteList.first(where: <#T##(Banknote) throws -> Bool#>)
        
        // FIXME: ask value of banknote from the class
        // FIXME: investigate using append method
        // FIXME: use value of banknote for calculations
        // FIXME: investigate using the optional return of array filtering (requiredBanknoteList.first)
        
        requiredBanknoteList[banknote.banknoteType] = (remainingSum / (banknote.banknoteType.rawValue))
        let remainingSum = (remainingSum % (banknote.banknoteType.rawValue))
        
        if ((requiredBanknoteList[banknote.banknoteType] ?? 0) <= banknote.quantity){
            let newQuantity = banknote.quantity - (requiredBanknoteList[banknote.banknoteType] ?? 0)
            
            if ((requiredBanknoteList[banknote.banknoteType] ?? 0) > 0) {
                banknote.update(quantity: newQuantity)
                print("Withdrawn: \(banknote.banknoteType.rawValue): \(requiredBanknoteList[banknote.banknoteType] ?? 0)")
            }
        } else {
            print("Error! Not enough banknotes left for the requested sum")
        }
        
        return remainingSum
    }
        
    // MARK: - Helpers
    // Helpers should be private, if not then it should be a "Tool" or extension in a separate file
    private func banknotesSortedDescending() -> [Banknote] {
        return banknoteList.sorted{ $0.banknoteType.rawValue > $1.banknoteType.rawValue }
    }
    
    private func sortedSmallBanknotes() -> [Banknote] {
        var smallBanknotes = banknoteList.filter{ $0.isSmallBanknote() }
        smallBanknotes.sort{ $0.banknoteType.rawValue > $1.banknoteType.rawValue }
        
        return smallBanknotes
    }
}

