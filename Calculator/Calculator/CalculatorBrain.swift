//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 晴耕雨读 on 2016/12/27.
//  Copyright © 2016年 晴耕雨读. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": .Constant(M_PI),
        "e": .Constant(M_E),
        "√": .UnaryOperation(sqrt),
        "cos": .UnaryOperation(cos),
        "sin": .UnaryOperation(sin),
        "tan": .UnaryOperation(tan),
        "+": .BinaryOperation({$0 + $1}),
        "−": .BinaryOperation({$0 - $1}),
        "×": .BinaryOperation({$0 * $1}),
        "÷": .BinaryOperation({$0 / $1}),
        "=": .Equals
    ]
    
    private struct BinaryOperationInfo {
        var function: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var binaryOperationInfo: BinaryOperationInfo?
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let assocVal):
                accumulator = assocVal
            case .UnaryOperation(let operation):
                accumulator = operation(accumulator)
            case .BinaryOperation(let operation):
                execPendingOperation()
                binaryOperationInfo = BinaryOperationInfo(function: operation, firstOperand: accumulator)
            case .Equals:
                execPendingOperation()
            }
        }
    }
    
    private func execPendingOperation() {
        if binaryOperationInfo != nil {
            accumulator = binaryOperationInfo!.function(binaryOperationInfo!.firstOperand, accumulator)
            binaryOperationInfo = nil
        }
    }
    
    var result : Double {
        get {
            return accumulator
        }
    }
}
