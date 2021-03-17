//
//  CalculatorViewController.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import UIKit

class CalculatorViewController: UIViewController {
    let calculations = Calculations()
    
    @IBOutlet private weak var calculationLabel: UILabel!
    
    @IBAction func onNumberTap(_ sender: UIButton) {
        let senderTag = sender.tag
        calculations.numberButtonOnTap(senderTag)
        calculationLabel.text = calculations.labelText
    }
    
    @IBAction func onCalculatorButtonTap(_ sender: UIButton) {
        let senderTag = sender.tag
        calculations.calculationButtonOnTap(senderTag)
        calculationLabel.text = calculations.labelText
    }
}
