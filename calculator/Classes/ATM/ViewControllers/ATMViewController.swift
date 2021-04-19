//
//  ATMViewController.swift
//  calculator
//
//  Created by Gabija on 2021-04-19.
//

import UIKit

class ATMViewController: UIViewController {
    
    // MARK: - Declarations
    private let atm = ATM()
    
    // MARK: - Methods
    @IBAction func refill(_ sender: UIButton) {
        atm.refillCash()
    }
    
    @IBAction func deposit(_ sender: UIButton) {
        atm.deposit(banknotes: [Banknote(.fifty, 51), Banknote(.twenty, 1), Banknote(.twoHundred, 15)])
    }
    
    @IBAction func withdraw(_ sender: UIButton) {
        atm.withdraw(requestedSum: 430, requiresSmallBanknotes: false)
    }
    
}
