//
//  Calculator.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation

class Calculator {
    
    // MARK: - Declarations
    var currentNumber = 0.0
    var previousNumber = 0.0
    var canEnterSecondNumber = false
    var selectedAction: ActionType? = nil
    var didTapAction = false
    var displayText = ""
    
    // MARK: - Methods
    func enterDigit(_ digit: Int) {
        guard digit >= 0, digit < 10 else {
            print ("ERROR! digit is out of boundaries: \(digit)")
            return
        }
        
        if displayText == "ERR0R" || didTapAction == true  {
            //FIXME: duplicates
            displayText = String(digit)
            currentNumber = Double(displayText) ?? 0.0
            didTapAction = false
        } else if canEnterSecondNumber == true {
            displayText = String(digit)
            currentNumber = Double(displayText) ?? 0.0
            canEnterSecondNumber = false
        } else {
            // insertDigitAtTheEnd(digit)
            displayText = displayText + String(digit)
            currentNumber = Double(displayText) ?? 0.0
        }
    }
    
    func didSelectAction(_ action: ActionType) {
        guard displayText != "" else {
            print ("Warning! Display text is empty")
            return
        }
        
        switch action { // FIXME: for practice sake, create 3 separate methods
        case .startCalculations:
            calculate()
            didTapAction = true
            
        case .reset:
            displayText = ""
            previousNumber = 0
            currentNumber = 0
            selectedAction = nil
            didTapAction = false
            
        default:
            guard let input = Double(displayText) else {
                return
            }
            previousNumber = input
            selectedAction = action
            canEnterSecondNumber = true
            didTapAction = false
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
            
        case .reset, .startCalculations:
            print("ERROR! received non-arithmetic function: \(action)")
            return
        }
    }
}




