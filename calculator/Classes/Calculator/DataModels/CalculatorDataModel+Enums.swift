//
//  CalculatorDataModel+Enums.swift
//  calculator
//
//  Created by Admin on 2021-03-18.
//

import Foundation

extension CalculatorDataModel {
    
    enum Digit:Int {
        case zero = 0 , one, two, three, four, five, six, seven, eight, nine
        
        var value: Int {
            return rawValue
        }
    }
    
    enum ActionType: String {
        case reset = "C"
        case divide = "/"
        case multiply = "X"
        case subtract = "-"
        case add = "+"
        case calculate = "="
        case remainder = "%"
        
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
