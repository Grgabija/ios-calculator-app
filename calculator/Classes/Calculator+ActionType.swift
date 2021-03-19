//
//  Calculator+ActionType.swift
//  calculator
//
//  Created by Admin on 2021-03-18.
//

import Foundation

extension Calculator {
    
    enum ActionType: Int {
        case reset = 11, divide, multiply, subtract, add, startCalculations, remainder
        
        func isArithmeticFunction() -> Bool {
            switch self {
            case .reset, .startCalculations:
                return false
            case .add, .divide, .multiply, .remainder, .subtract:
                return true
            }
        }
    }
}
