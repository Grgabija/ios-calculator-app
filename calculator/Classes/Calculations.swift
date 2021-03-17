//
//  Calculations.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation
import UIKit

enum ButtonLabels :Int {
    case delete = 11, divide, multiply, subtract, add, equal, remainder
    
}

class Calculations {
    var numberOnScreen = 0.0
    var previousNumber = 0.0
    var isPerformingMath = false
    var operation = 0
    var isAnswerShown = false
    var labelText = ""

    func numberButtonOnTap(_ senderTag: Int, _ label: String) {
        
        if labelText == "ERR0R" || isAnswerShown == true  {
            labelText = String(senderTag-1)
            numberOnScreen = Double(labelText)!
            isAnswerShown = false
        } else if isPerformingMath == true {
            labelText = String(senderTag-1)
            numberOnScreen = Double(labelText)!
            isPerformingMath = false
        } else {
            labelText = labelText + String(senderTag-1)
            numberOnScreen = Double(labelText)!
        }
    }
    
    func calculationButtonOnTap(_ senderTag: Int, _ label: String) {
        
        if labelText != "", senderTag != 11, senderTag != 16 { //replace numbers
            guard let input = Double(labelText) else {
                return
            }
            
            previousNumber = input
            
         /*   switch ButtonLabels(rawValue: sender.tag) {
            case .divide:
                label.text = "/" //do the same with tag part
            case .multiply: //Multiply
                label.text = "x"
            case .subtract: //Subtract
                label.text = "-"
            case .add: //Add
                label.text = "+"
            case .remainder: //Remainder
                label.text = "%"
            default:
                label.text = ""
            }*/
            
            operation = senderTag
            isPerformingMath = true
            isAnswerShown = false
        } else if senderTag == 16 {
            mathematicalOperations(senderTag, label)
            isAnswerShown = true
        } else if senderTag == 11 {
            labelText = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            isAnswerShown = false
        }
    }

    func mathematicalOperations(_ senderTag: Int, _ label: String) {
        switch operation {
        case 12: //Divide
            guard numberOnScreen != 0 else {
                return labelText = "ERR0R"
            }
            labelText = String(previousNumber / numberOnScreen)
        case 13: //Multiply
            labelText = String(previousNumber * numberOnScreen)
        case 14: //Subtract
            labelText = String(previousNumber - numberOnScreen)
        case 15: //Add
            labelText = String(previousNumber + numberOnScreen)
        case 17: //Remainder
            guard numberOnScreen != 0 else {
                return labelText = "ERR0R"
            }
            labelText = String(previousNumber.truncatingRemainder(dividingBy: numberOnScreen))
        default:
            return
        }
    }
}
