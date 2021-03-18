//
//  Calculator.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation
import UIKit

//
// buvo ivestas skaicius, po to buvo ivesta operacija, po to galima vesti skaiciu
// buvo ivestas skaicius, po to buvo ivesta operacija => true
// skaiciaus nera = false
// operacija = false

// isFirstNumberAndOperationProvided - technical // ugly + aiskesnis
// canEnterSecondNumber - technical
//
//
// isPerformingCalculation // vs. nice but misleading


// isNumberandOperationnoptSet - technical
// hasNothingEntered - high

class Calculator {
    
    // MARK: - Declarations
    var currentNumber = 0.0
    var previousNumber = 0.0
    
    var isPerformingCalculation = false // FIXME: misleading
        
    var selectedAction: ActionType? = nil
    var isAnswerShown = false // FIXME: negalima suvedinet papildomu skaiciu, paskirtis
                              // canEnterNumbers
    var displayText = ""
    
    // MARK: - Methods
    func enterDigit(_ digit: Int) {
        
        guard digit >= 0, digit < 10 else {
            // print error
            return
        }
        
        if displayText == "ERR0R" || isAnswerShown == true  {
// FIXME: del later
//             or something like? :
//             numberOnScreen = Double(senderTag-1)
//             labelText = String(numberOnScreen)
            
            displayText = String(digit-1) // FIXME: -1 should nto be here, also is a duplication
            currentNumber = Double(displayText) ?? 0.0
            isAnswerShown = false
        } else if isPerformingCalculation == true {
            displayText = String(digit-1) // FIXME: -1 should nto be here
            currentNumber = Double(displayText) ?? 0.0
            isPerformingCalculation = false
        } else {
            // insertDigitAtTheEnd(digit)
            displayText = displayText + String(digit-1) // FIXME: -1 should nto be here
            currentNumber = Double(displayText) ?? 0.0
        }
    }
    
    func calculationButtonOnTap(_ action: ActionType) {
        
        if displayText != "",
           action != .delete,
           action != .equal {
            
            guard let input = Double(displayText) else {
                return
            }
            previousNumber = input
            self.selectedAction = action
            isPerformingCalculation = true
            isAnswerShown = false
            
        } else if action == .equal {
            calculate()
            isAnswerShown = true
            
        } else if action == .delete {
            displayText = ""
            previousNumber = 0
            currentNumber = 0
            self.selectedAction = nil
            isAnswerShown = false
        }
    }
    
    func calculate() {
        guard let action = selectedAction,
              action.isArithmeticFunction() else {
            return
        }
        
        switch action {
        case .divide:
            guard currentNumber != 0 else {
                return displayText = "ERR0R"
            }
            displayText = String(previousNumber / currentNumber)
            
        case .multiply:
            displayText = String(previousNumber * currentNumber)
            
        case .subtract:
            displayText = String(previousNumber - currentNumber)
            
        case .add:
            displayText = String(previousNumber + currentNumber)
            
        case .remainder:
            guard currentNumber != 0 else {
                return displayText = "ERR0R"
            }
            displayText = String(previousNumber.truncatingRemainder(dividingBy: currentNumber))
        
        case .delete, .equal:
            print("ERROR! received non-arithmetic function: \(action)")
            return
        }
    }
}
