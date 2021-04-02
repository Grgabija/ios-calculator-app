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
        banknoteList = Banknote.BanknoteVariant.allCases.map { Banknote($0, 0) }
        print(banknoteList)
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
                let banknoteToUpdate = self.banknoteList.first{ $0.banknoteVariant == banknote.banknoteVariant }
                banknoteToUpdate?.update(quantity: banknoteToUpdate?.quantity ?? 0 + banknote.quantity)
                print("Added to the bank account \(banknote.banknoteVariant.rawValue): \(banknote.quantity)")
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
        let requiredBanknoteList: [Banknote] = []
        let banknotesSorted: [Banknote]
        var remainingSum = requestedSum
        
        if requiresSmallBanknotes{
            banknotesSorted = sortedSmallBanknotes()
        } else {
            banknotesSorted = banknotesSortedDescending()
        }
        
        for banknote in banknotesSorted {
            remainingSum = calculateBanknotesForWithdrawal(banknotesInATM: banknote, remainingSum: remainingSum, requiredBanknoteList: requiredBanknoteList)
        }
    }
    
    // MARK: - Private
    private func calculateBanknotesForWithdrawal(banknotesInATM: Banknote, remainingSum: Int, requiredBanknoteList: [Banknote]) -> Int {  //FIXME: naming
        // Naming of a method should be based on what a method does, not information outside of that
        // method. A method has no idea who called it and for what reason
        
//        guard let banknote = (requiredBanknoteList.first{ $0.banknoteVariant == banknotesInATM.banknoteVariant }) else {
//            print("Error")
//            return remainingSum
//        }
        let banknoteQuantity = (remainingSum / (banknotesInATM.showBanknoteValue()))
        
        let remainingSum = (remainingSum % (banknotesInATM.showBanknoteValue()))
        print("Withdrawn: \(banknotesInATM.showBanknoteValue()): \(banknoteQuantity)")
        // TODO
        // get amount of banknotes available and substract from remainingSum
        // add to the list of requiredBanknotes (look into the append method)
        // HINT: variant + number of notes needed (maybe have to initialize new banknotes)
        // --> TODO: list is good, but check WHERE it should be - done
        

//
//
//        if ((requiredBanknoteList[banknote.banknoteType] ?? 0) <= banknote.quantity){
//            let newQuantity = banknote.quantity - (requiredBanknoteList[banknote.banknoteType] ?? 0)
//
//            if ((requiredBanknoteList[banknote.banknoteType] ?? 0) > 0) {
//                banknote.update(quantity: newQuantity)
//
//            }
//        } else {
//            print("Error! Not enough banknotes left for the requested sum")
//        }
//
        return remainingSum
    }
        
    // MARK: - Helpers
    // Helpers should be private, if not then it should be a "Tool" or extension in a separate file
    private func banknotesSortedDescending() -> [Banknote] {
        return banknoteList.sorted{ $0.banknoteVariant.rawValue > $1.banknoteVariant.rawValue }
    }
    
    private func sortedSmallBanknotes() -> [Banknote] {
        var smallBanknotes = banknoteList.filter{ $0.isSmallBanknote() }
        smallBanknotes.sort{ $0.banknoteVariant.rawValue > $1.banknoteVariant.rawValue }
        
        return smallBanknotes
    }
}

// banknoteList.first can return nil if the condition is not met, so it's value is optional
// in order to continue, an actual banknote needs to be found
// guard let attempts to assign the result of .first into a non-optional value
// if it succeeds, we can continue, if not it goes into else statement and returns
// this is called "Unwrapping optionals"
// guard is used for essential elements and to early exit
//guard let banknote = (requiredBanknoteList.first{ $0.banknoteVariant == banknote.banknoteVariant }) else {
//    print("Error")
//    return remainingSum
//}

//guard let couple == present else {
//  can't have a party
//  return
//}
//
// have good party
//

    
// if let also unwraps, but is used for a conditional execution in case certain elements are there
// and multiple options are available and accepted.
// NOT to be used for early exits
//if let banknote = (requiredBanknoteList.first{ $0.banknoteVariant == banknote.banknoteVariant }) {
//    print("Error")
//    return remainingSum
//} else {
//    ///
//}

//if let motherInlaw == present {
//  have bad party
//} else {
// have good party
//}

