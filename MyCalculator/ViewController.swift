//
//  ViewController.swift
//  MyCalculator
//
//  Created by kul on 31/10/17.
//  Copyright © 2017 kuldeep Singh Bani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculatorModel = CalculatorModel()
    var isOperationPerform = false
    var isEqualsPressed = false
    
    @IBOutlet weak var digitLabel: UILabel!
    
    var didStartTyping = false
    
    var digitValue :Double {
        get{
            return Double(digitLabel.text!)!
        }
        set{
            if newValue == 0.0{
                digitLabel.text = "0"
            }else{
                digitLabel.text = String(newValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func touchDigitButtonAction(_ sender: UIButton) {
//        isEqualsPressed = false
        let currentTitle = sender.currentTitle!
        let labelTitle = digitLabel.text!
        isOperationPerform = false
        if currentTitle == "."{
            if  labelTitle.contains("."){
               return
            }
            else{
                didStartTyping = true
            }
        }
        
        if didStartTyping{
            digitLabel.text = labelTitle + currentTitle
        }else{
            digitLabel.text = currentTitle
            didStartTyping = true
        }
    }
    
    @IBAction func performOperationButtonAction(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle!
        
        if buttonTitle == "C"{
            digitLabel.text  = "0"
            calculatorModel.setOperand(0)
            didStartTyping   = false
            return
        }
        
        if buttonTitle == "=" {
            if isEqualsPressed{
                return
            }else {
                isEqualsPressed = true
            }
        }else{
            isEqualsPressed = false
        }
        
        if(didStartTyping ){
        
            if Double(digitLabel.text!) == 0.0 {
                calculatorModel.setOperand(0)
            }else{
                calculatorModel.setOperand(digitValue)
            }
            didStartTyping = false
        }
        calculatorModel.performOperation(buttonTitle)
        
        if let result =  calculatorModel.resultValue{
            digitValue = result
        }

        isOperationPerform = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

