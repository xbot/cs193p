//
//  ViewController.swift
//  Calculator
//
//  Created by 晴耕雨读 on 2016/12/26.
//  Copyright © 2016年 晴耕雨读. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var display: UILabel!
    
    private var continueInputing = false
    
    private var brain = CalculatorBrain()
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let displayText = display.text!
        
        if continueInputing {
            display.text = displayText + digit
        } else {
            display.text = digit
        }
        continueInputing = true
    }
    
    @IBAction private func touchOperator(_ sender: UIButton) {
        if continueInputing {
            brain.setOperand(operand: displayValue)
            continueInputing = false
        }
        
        if let opr = sender.currentTitle {
            brain.performOperation(symbol: opr)
        }
        displayValue = brain.result
    }
}

