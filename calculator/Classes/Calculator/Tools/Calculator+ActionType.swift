//
//  Calculator+ActionType.swift
//  calculator
//
//  Created by Admin on 2021-03-18.
//

import Foundation

extension CalculatorDataModel {
    
    enum ActionType: Int {
        case reset = 11, divide, multiply, subtract, add, calculate, remainder
        
        func isArithmeticFunction() -> Bool {
            switch self {
            case .reset, .calculate:
                return false
            case .add, .divide, .multiply, .remainder, .subtract:
                return true
            }
        }
    }
}
