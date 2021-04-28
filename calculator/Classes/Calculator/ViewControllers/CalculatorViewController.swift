//
//  CalculatorViewController.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    // MARK: - Declarations
    private let calculator = CalculatorDataModel()
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    // MARK: - Methods
    @IBAction func onNumberTap(_ sender: UIButton) {
        
        guard let currentTitle = sender.currentTitle,
              let digit = CalculatorDataModel.Digit(rawValue: (Int(currentTitle) ?? 0)) else {
            print("ERROR! unexpected buttonTitle: \(sender.currentTitle ?? "nil")")
            return
        }
        
        calculator.enterDigit(digit: digit.rawValue)
        displayLabel.text = calculator.result
    }
    
    @IBAction func onActionButtonTap(_ sender: UIButton) {
        guard let currentTitle = sender.currentTitle,
              let action = CalculatorDataModel.ActionType(rawValue: currentTitle) else {
            print("ERROR! unexpected buttonTitle: \(sender.currentTitle ?? "nil")")
            return
        }
        
        calculator.selectAction(action: action)
        displayLabel.text = calculator.result
    }
}
