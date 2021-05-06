//
//  CalculatorViewController.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    // MARK: - Declarations
    private let calculatorDataModel = CalculatorDataModel()
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    // MARK: - Methods
    @IBAction func onNumberTap(_ sender: UIButton) {
        guard let currentTitle = sender.currentTitle,
              let currentTitleParsedAsInt = Int(currentTitle),
              let digit = CalculatorDataModel.Digit(rawValue: currentTitleParsedAsInt) else {
            print("ERROR! unexpected buttonTitle: \(String(describing: sender.currentTitle))")
            return
        }
        
        calculatorDataModel.enterDigit(digit: digit)
        displayLabel.text = calculatorDataModel.result
    }
    
    @IBAction func onActionButtonTap(_ sender: UIButton) {
        guard let currentTitle = sender.currentTitle,
              let action = CalculatorDataModel.ActionType(rawValue: currentTitle) else {
            print("ERROR! unexpected buttonTitle: \(String(describing: sender.currentTitle))")
            return
        }
        
        calculatorDataModel.selectAction(action: action)
        displayLabel.text = calculatorDataModel.result
    }
}
