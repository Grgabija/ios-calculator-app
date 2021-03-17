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
    
    @IBAction func onNumberTap(_ sender: UIButton) { //onNumberTap
        let labelText = calculationLabel.text ?? ""
        let senderTag = sender.tag
        calculations.numberButtonOnTap(senderTag, labelText)
        calculationLabel.text = calculations.labelText
    }
    
    @IBAction func onCalculatorButtonTap(_ sender: UIButton) { //onCalculatorButtonTap
        let labelText = calculationLabel.text ?? ""
        let senderTag = sender.tag
        calculations.calculationButtonOnTap(senderTag, labelText)
        calculationLabel.text = calculations.labelText
    }
}
