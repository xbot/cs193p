//
//  ViewController.swift
//  Calculator
//
//  Created by 晴耕雨读 on 2016/12/26.
//  Copyright © 2016年 晴耕雨读. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var continueInputing = false

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let displayText = display.text!
        
        if continueInputing {
            display.text = displayText + digit
        } else {
            display.text = digit
        }
        continueInputing = true
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        continueInputing = false
        
        if let opr = sender.currentTitle {
            if opr == "π" {
                display.text = String(M_PI)
            }
        }
    }
}

