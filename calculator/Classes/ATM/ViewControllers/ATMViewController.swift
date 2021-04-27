//
//  ATMViewController.swift
//  calculator
//
//  Created by Gabija on 2021-04-19.
//

import UIKit

class ATMViewController: UIViewController {
    
    // MARK: - Constants
    private let kDefaultQuantity = 2
    
    // MARK: - Declarations
    private let atmDataModel = ATMDataModel()
    
    // MARK: - Methods
    @IBAction func refill(_ sender: UIButton) {
        atmDataModel.refillCash(refillBanknoteList: [Banknote(.oneHundred, quantity: kDefaultQuantity),
                                                     Banknote(.fifty, quantity: kDefaultQuantity),
                                                     Banknote(.ten, quantity: kDefaultQuantity),
                                                     Banknote(.five, quantity: kDefaultQuantity)
        ]
        )
    }
    
    @IBAction func deposit(_ sender: UIButton) {
        atmDataModel.deposit(banknotes: [Banknote(.fifty, quantity: 51), Banknote(.twenty, quantity: 1), Banknote(.twoHundred, quantity: 15)])
    }
    
    @IBAction func withdraw(_ sender: UIButton) {
        atmDataModel.withdraw(requestedSum: 10, requiresSmallBanknotes: true)
    }
    
}
