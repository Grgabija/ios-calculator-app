//
//  Calculator.swift
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
    private var didTapAction = false
    var displayText = ""
    
    // MARK: - Methods
    func enterDigit(_ digit: Int) {
        guard digit >= 0, digit < 10 else {
            print ("ERROR! digit is out of boundaries: \(digit)")
            return
        }
        
        if displayText == "ERR0R" || didTapAction == true {
            setCurrentData(digit)
            didTapAction = false
        } else if canEnterSecondNumber == true {
            setCurrentData(digit)
            canEnterSecondNumber = false
        } else {
            insertDigitAtTheEnd(digit)
        }
    }
    
    private func setCurrentData(_ digit: Int) {
        displayText = String(digit)
        currentNumber = Double(displayText) ?? 0.0
    }
    
    private func insertDigitAtTheEnd(_ digit: Int) {
        displayText = displayText + String(digit)
        currentNumber = Double(displayText) ?? 0.0
    }
    
    func didSelectAction(_ action: ActionType) {
        guard displayText != "" else {
            print ("Warning! Display text is empty")
            return
        }
        
        switch action {
        case .startCalculations:
            calculate()
            
        case .reset:
            reset()
            
        default:
            selectMathematicalAction(action)
        }
    }
    
    private func calculate() {
        guard let action = selectedAction,
              action.isArithmeticFunction() else {
            return
        }
        didTapAction = true
        
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
    
    private func reset() {
        displayText = ""
        previousNumber = 0
        currentNumber = 0
        selectedAction = nil
        didTapAction = false
    }
    
    private func selectMathematicalAction(_ action: ActionType) {
        guard let input = Double(displayText) else {
            return
        }
        previousNumber = input
        selectedAction = action
        canEnterSecondNumber = true
        didTapAction = false
    }
}
