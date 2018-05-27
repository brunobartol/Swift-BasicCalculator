//
//  Kalkulator.model.swift
//  Kalkulator
//
//  Created by Admin on 25.05.2017..
//  Copyright © 2017. BrunoBartol. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var akumulator: Double?
    
    //tipovi operacija
    private enum Operacija{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    
    //popis operacija
    private var operacije: Dictionary<String, Operacija> = [
        "∏": Operacija.constant(Double.pi),
        "√": Operacija.unaryOperation(sqrt),
        "=": Operacija.equals,
        "+": Operacija.binaryOperation({$0 + $1}),
        "-": Operacija.binaryOperation({$0 - $1}),
        "×": Operacija.binaryOperation({$0 * $1}),
        "÷": Operacija.binaryOperation({$0 / $1}),
        "±": Operacija.unaryOperation({-$0}),
    ]
    
    
    //struktura za cekajucu operaciju
    struct PendingBinaryOperation {
        let funkcija: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return funkcija(firstOperand, secondOperand)
        }
    }
    
    
    //varijabla za cekajucu operaciju
    private var pbo: PendingBinaryOperation?
    
    
    //funkcija za izvodjenje cekajuce operacije
    private mutating func performPendingBinaryOperation() {
        if pbo != nil && akumulator != nil {
            akumulator = pbo!.perform(with: akumulator!)
        }
    }
    
    
    //izvodjenje operacija
    mutating func performOperation(_ simbol:String){
        
        if let operacija = operacije[simbol]{
        
            switch operacija {
            case .constant(let vrijednost):
                akumulator = vrijednost
            case .unaryOperation(let funkcija):
                if akumulator != nil{
                    akumulator = funkcija(akumulator!)
                }
            case .binaryOperation(let funkcija):
                if akumulator != nil{
                    pbo = PendingBinaryOperation(funkcija: funkcija, firstOperand: akumulator!)
                    akumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    

    mutating func setOperand(_ operand: Double){
        akumulator = operand
    }
    
    var result: Double? {
        get {
            return akumulator
        }
    }
}
