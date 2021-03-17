//
//  Calculations.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation
import UIKit

class Calculations {
    enum ButtonLabels :Int {
        case delete = 11, divide, multiply, subtract, add, equal, remainder
        
    }
    var numberOnScreen = 0.0
    var previousNumber = 0.0
    var isPerformingMath = false
    var operation: ButtonLabels? = nil
    var isAnswerShown = false
    var labelText = ""
    
    func numberButtonOnTap(_ senderTag: Int) {
        
        if labelText == "ERR0R" || isAnswerShown == true  {
            /* or something like? :
             numberOnScreen = Double(senderTag-1)
             labelText = String(numberOnScreen)*/
            labelText = String(senderTag-1)
            numberOnScreen = Double(labelText) ?? 0.0
            isAnswerShown = false
        } else if isPerformingMath == true {
            labelText = String(senderTag-1)
            numberOnScreen = Double(labelText) ?? 0.0
            isPerformingMath = false
        } else {
            labelText = labelText + String(senderTag-1)
            numberOnScreen = Double(labelText) ?? 0.0
        }
    }
    
    func calculationButtonOnTap(_ senderTag: Int) {
        if labelText != "", ButtonLabels(rawValue: senderTag) != .delete, ButtonLabels(rawValue: senderTag) != .equal {
            guard let input = Double(labelText) else {
                return
            }
            previousNumber = input
            operation = ButtonLabels(rawValue: senderTag)
            isPerformingMath = true
            isAnswerShown = false
        } else if ButtonLabels(rawValue: senderTag) == .equal {
            mathematicalOperations(senderTag)
            isAnswerShown = true
        } else if ButtonLabels(rawValue: senderTag) == .delete {
            labelText = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = nil
            isAnswerShown = false
        }
    }
    
    func mathematicalOperations(_ senderTag: Int) {
        switch operation {
        case .divide:
            guard numberOnScreen != 0 else {
                return labelText = "ERR0R"
            }
            labelText = String(previousNumber / numberOnScreen)
        case .multiply: 
            labelText = String(previousNumber * numberOnScreen)
        case .subtract:
            labelText = String(previousNumber - numberOnScreen)
        case .add:
            labelText = String(previousNumber + numberOnScreen)
        case .remainder:
            guard numberOnScreen != 0 else {
                return labelText = "ERR0R"
            }
            labelText = String(previousNumber.truncatingRemainder(dividingBy: numberOnScreen))
        default:
            return
        }
    }
}
