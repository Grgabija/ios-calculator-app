//
//  CalculatorViewController.swift
//  calculator
//
//  Created by Gabija on 2021-03-15.
//

import UIKit

class CalculatorViewController: UIViewController {
    let calculation = Calculations()

    
    @IBAction func numbers(_ sender: UIButton) {
        calculation.numberButtonsOnTap(sender, calculationLabel)
       
    }
    
    @IBOutlet weak var calculationLabel: UILabel!
    
    @IBAction func calculatorButtons(_ sender: UIButton) {
        calculation.calculationButtonsOnTap(sender, calculationLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {

    super.didReceiveMemoryWarning()

    // Dispose of any resources that can be recreated.

    }
    
}






