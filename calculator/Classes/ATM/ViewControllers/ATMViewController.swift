//
//  ATMViewController.swift
//  calculator
//
//  Created by Gabija on 2021-04-19.
//

import UIKit

class ATMViewController: UIViewController {
    
    // MARK: - Declarations
    private let atmDataModel = ATMDataModel()
    
    // MARK: - Methods
    @IBAction func refill(_ sender: UIButton) {
        atmDataModel.refillCash(refillBanknoteList: [Banknote(.fifty, 0)])
    }
    
    @IBAction func deposit(_ sender: UIButton) {
        atmDataModel.deposit(banknotes: [Banknote(.fifty, 51), Banknote(.twenty, 1), Banknote(.twoHundred, 15)])
    }
    
    @IBAction func withdraw(_ sender: UIButton) {
        atmDataModel.withdraw(requestedSum: 100, requiresSmallBanknotes: false)
    }
    
}
