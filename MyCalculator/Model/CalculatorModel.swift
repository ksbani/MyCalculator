//
//  CalculatorModel.swift
//  MyCalculator
//
//  Created by kul on 31/10/17.
//  Copyright © 2017 kuldeep Singh Bani. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    private var accumulateVar : Double?
    
    private enum OperationType {
        case constant(Double)
        case Unary((Double)->Double)
        case Binary((Double,Double)->Double)
        case Equals
    }
    
//MARK: - functionalTable Dictionary
    private var functionalTable : Dictionary <String,OperationType> = [
        "π" : OperationType.constant(M_PI),
        "√" : OperationType.Unary(sqrt),
        "±" : OperationType.Unary({ -$0 }),
        "+": OperationType.Binary({$0 + $1}),
        "-": OperationType.Binary({$0 - $1}),
        "×": OperationType.Binary({$0 * $1}),
        "÷": OperationType.Binary({$0 / $1}),
        "=": OperationType.Equals
        
    ]

//MARK: - setOperand function
    mutating func setOperand(_ operand : Double)  {
        accumulateVar = operand
    }
    
//MARK: - performOperation func
    mutating func performOperation(_ operation:String){
        if let operationValue = functionalTable[operation]{
            switch operationValue {
            case .constant(let function):
                accumulateVar = function
            case .Unary(let function):
                if(accumulateVar != nil){
                    accumulateVar = function(accumulateVar!)
                }
            case .Binary(let function):
                if accumulateVar != nil{
                    pbo = PerformBinaryOperation(function: function, firstOprand: accumulateVar!)
                    accumulateVar = nil
                }
            case .Equals:
                performBinaryOperation()
            }
            
        }
        
    }
    
    // branch A commit
    var resultValue : Double?{
        get{
            return accumulateVar
        }
    }
    
    private mutating func performBinaryOperation() {
        if accumulateVar != nil && pbo != nil {
            accumulateVar = pbo?.perform(with: accumulateVar!)
        }
    }
    
    private var pbo : PerformBinaryOperation?
    
    private struct PerformBinaryOperation {
        let function : (Double,Double)-> Double
        let firstOprand : Double
        
        func perform(with secondOperand:Double)-> Double {
            return function(firstOprand , secondOperand)
        }
        
    }
    
    
}
