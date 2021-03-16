//
//  Calculations.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import Foundation
import UIKit

class Calculations {
    var numberOnScreen: Double = 0;
    var previousNumber: Double = 0;
    var performingMath = false;
    var operation = 0;
    
    

    
    func numberButtonsOnTap( _ sender: UIButton, _ label: UILabel) {
        
        if performingMath == true {
            label.text = String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
            performingMath = false
        }
        
        else {
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
        }
    }
    
    func calculationButtonsOnTap( _ sender: UIButton, _ label: UILabel) {

        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            
            guard let input = Double(label.text!) else {
                return
            }
            previousNumber = input
            
            if sender.tag == 12 { //Divide
                label.text = "/";
            }
            
            if sender.tag == 13 { //Multiply
                label.text = "x";
            }
            
            if sender.tag == 14 { //Subtract
                label.text = "-";
            }
            
            if sender.tag == 15 { //Add
                label.text = "+";
            }
            
            if sender.tag == 17 { //Remainder
                label.text = "%"
            }
            
            operation = sender.tag
            performingMath = true;
            
        }
        
        
        else if sender.tag == 16 {

            if operation == 12{ //Divide
                guard numberOnScreen != 0 else {
                    return label.text = "ERR0R"
                }
                label.text = String(previousNumber / numberOnScreen)
            }
            
            else if operation == 13{ //Multiply
                label.text = String(previousNumber * numberOnScreen)
            }
            
            else if operation == 14{ //Subtract
                label.text = String(previousNumber - numberOnScreen)
            }
            
            else if operation == 15{ //Add
                label.text = String(previousNumber + numberOnScreen)
            }
            
            else if operation == 17{ //Remainder
                guard numberOnScreen != 0 else {
                    return label.text = "ERR0R"
                }
                label.text = String(previousNumber.truncatingRemainder(dividingBy: numberOnScreen))
            }
            
        }
        
        else if sender.tag == 11{
            label.text = ""
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
        }
        
    
    }
}

    
