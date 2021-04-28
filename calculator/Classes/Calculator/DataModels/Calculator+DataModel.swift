//
//  Calculator+DataModel.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation

class CalculatorDataModel {
    
    // MARK: - Declarations
    private var currentNumber = 0.0
    private var previousNumber = 0.0
    private var selectedAction: ActionType? = nil
    private var canEnterSecondNumber = false
    private var didCalculation = false
    var result = ""
    
    // MARK: - Methods
    // MARK: - Public
    func enterDigit(digit: Int) {
        guard digit >= 0, digit < 10 else {
            print ("ERROR! digit is out of boundaries: \(digit)")
            return
        }
        
        if result == "ERR0R" || didCalculation == true {
            updateResult(digit: digit)
            didCalculation = false
        } else if canEnterSecondNumber == true {
            updateResult(digit: digit)
            canEnterSecondNumber = false
        } else {
            appendDigit(digit: digit)
        }
    }
    
    func selectAction(action: ActionType) {
        guard result.isEmpty == false else {
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
            selectMathematicalAction(action: action)
            didCalculation = false
        }
    }
    
    // MARK: - Private
    private func calculate() {
        guard let action = selectedAction,
              action.isArithmeticFunction() else {
            return
        }
        
        switch action {
        case .divide:
            guard currentNumber != 0 else {
                return result = "ERR0R"
            }
            
            result = String(previousNumber / currentNumber)
            
        case .multiply:
            result = String(previousNumber * currentNumber)
            
        case .subtract:
            result = String(previousNumber - currentNumber)
            
        case .add:
            result = String(previousNumber + currentNumber)
            
        case .remainder:
            guard currentNumber != 0 else {
                return result = "ERR0R"
            }
            
            result = String(previousNumber.truncatingRemainder(dividingBy: currentNumber))
            
        case .reset, .calculate:
            print("ERROR! received non-arithmetic function: \(action)")
            return
        }
    }
    
    private func reset() {
        result = ""
        previousNumber = 0
        currentNumber = 0
        selectedAction = nil
    }
    
    // MARK: - Helpers
    private func updateResult(digit: Int) {
        result = String(digit)
        currentNumber = Double(result) ?? 0.0
    }
    
    private func appendDigit(digit: Int) {
        result = result + String(digit)
        currentNumber = Double(result) ?? 0.0
    }
    
    private func selectMathematicalAction(action: ActionType) {
        guard let input = Double(result) else {
            return
        }
        
        previousNumber = input
        selectedAction = action
        canEnterSecondNumber = true
    }
}
