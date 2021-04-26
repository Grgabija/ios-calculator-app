//
//  Calculator+DataModel.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation

class Calculator {
    
    // MARK: - Declarations
    private var currentNumber = 0.0
    private var previousNumber = 0.0
    private var canEnterSecondNumber = false
    private var selectedAction: ActionType? = nil
    private var didCalculation = false
    var displayText = ""
    
    // MARK: - Methods
    func enterDigit(_ digit: Int) {
        guard digit >= 0, digit < 10 else {
            print ("ERROR! digit is out of boundaries: \(digit)")
            return
        }
        
        if displayText == "ERR0R" || didCalculation == true {
            updateDisplayText(digit)
            didCalculation = false
        } else if canEnterSecondNumber == true {
            updateDisplayText(digit)
            canEnterSecondNumber = false
        } else {
            appendDigit(digit)
        }
    }
    
    private func updateDisplayText(_ digit: Int) {
        displayText = String(digit)
        currentNumber = Double(displayText) ?? 0.0
    }
    
    private func appendDigit(_ digit: Int) {
        displayText = displayText + String(digit)
        currentNumber = Double(displayText) ?? 0.0
    }
    
    func didSelectAction(_ action: ActionType) {
        guard displayText != "" else {
            print ("Warning! Display text is empty")
            return
        }
        
        switch action {
        case .calculate:
            calculate()
            didCalculation = true
        
        case .reset:
            reset()
            didCalculation = false
            
        default:
            selectMathematicalAction(action)
            didCalculation = false
        }
    }
    
    private func calculate() {
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
            
        case .reset, .calculate: 
            print("ERROR! received non-arithmetic function: \(action)")
            return
        }
    }
    
    private func reset() {
        displayText = ""
        previousNumber = 0
        currentNumber = 0
        selectedAction = nil
    }
    
    private func selectMathematicalAction(_ action: ActionType) {
        guard let input = Double(displayText) else {
            return
        }
        previousNumber = input
        selectedAction = action
        canEnterSecondNumber = true
    }
}
