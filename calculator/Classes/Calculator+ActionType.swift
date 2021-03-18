//
//  Calculator+ActionType.swift
//  calculator
//
//  Created by Admin on 2021-03-18.
//

import Foundation

extension Calculator {
    
    enum ActionType: Int {
        // FIXME: delete -> clear/reset (?)
        // FIXME: qual -> startCalculations
        case delete = 11, divide, multiply, subtract, add, equal, remainder

        func isArithmeticFunction() -> Bool {
            switch self {
            case .delete, .equal:
                return false
            case .add, .divide, .multiply, .remainder, .subtract:
                return true
            }
        }
    }
}
