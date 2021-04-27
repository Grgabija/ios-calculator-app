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
        guard let digit = Number.Digit(rawValue: (sender.tag-1)) else {
            print("ERROR! unexpected buttonTag: \(sender.tag)")
            return
        }
       
        calculator.enterDigit(digit.rawValue)
        displayLabel.text = calculator.displayText
    }
    
    @IBAction func onActionButtonTap(_ sender: UIButton) {
        guard let action = CalculatorDataModel.ActionType(rawValue: sender.tag) else {
            print("ERROR! unexpected buttonTag: \(sender.tag)")
            return
        }
        
        calculator.didSelectAction(action)
        displayLabel.text = calculator.displayText
    }
}
