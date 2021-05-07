//
//  CalculatorDataModel.swift
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
    func enterDigit(_ digit: Digit) {
        let digitValue = digit.value
        
        guard digitValue >= 0, digitValue < 10 else {
            print ("ERROR! digit is out of boundaries: \(digit)")
            return
        }
        
        if result == "ERR0R" || didCalculation == true {
            updateResult(digit)
            didCalculation = false
        } else if canEnterSecondNumber == true {
            updateResult(digit)
            canEnterSecondNumber = false
        } else {
            appendDigit(digit)
        }
    }
    
    func selectAction(_ action: ActionType) {
        guard result.isEmpty == false else {
            print ("Warning! Display text is empty")
            return
        }
        
        switch action {
        case .calculate:
            if let calculationResult = calculate() {
                result = calculationResult
                didCalculation = true
            }
            
        case .reset:
            reset()
            didCalculation = false
            
        default:
            selectMathematicalAction(action: action)
            didCalculation = false
        }
    }
    
    // MARK: - Private
    private func calculate() -> String? {
        guard let action = selectedAction,
              action.isArithmeticFunction() else {
            return nil
        }
        var calculationResult = ""
        
        switch action {
        case .divide:
            guard currentNumber != 0 else {
                return "ERR0R"
            }
            
            calculationResult = String(previousNumber / currentNumber)
            
        case .multiply:
            calculationResult = String(previousNumber * currentNumber)
            
        case .subtract:
            calculationResult = String(previousNumber - currentNumber)
            
        case .add:
            calculationResult = String(previousNumber + currentNumber)
            
        case .remainder:
            guard currentNumber != 0 else {
                return "ERR0R"
            }
            
            calculationResult = String(previousNumber.truncatingRemainder(dividingBy: currentNumber))
            
        case .reset, .calculate:
            print("ERROR! received non-arithmetic function: \(action)")
            return nil
        }
        return calculationResult
    }
    
    private func reset() {
        result = ""
        previousNumber = 0
        currentNumber = 0
        selectedAction = nil
    }
    
    // MARK: - Helpers
    private func updateResult(_ digit: Digit) {
        result = String(digit.value)
        currentNumber = Double(result) ?? 0.0
    }
    
    private func appendDigit(_ digit: Digit) {
        result = result + String(digit.value)
        currentNumber = Double(result) ?? 0.0
    }
    
    private func selectMathematicalAction(action: ActionType) {
        previousNumber = Double(result) ?? 0.0
        selectedAction = action
        canEnterSecondNumber = true
    }
}
