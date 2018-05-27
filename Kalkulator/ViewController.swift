//
//  ViewController.swift
//  Kalkulator
//
//  Created by Admin on 23.05.2017..
//  Copyright © 2017. BrunoBartol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //povezivanje displaya
    @IBOutlet weak var display: UILabel!
    
    //bool za odredjivanje je li osoba usred upisivanja brojeva
    var usredTipkanja = false
    
    //povezivanje brojeva
    @IBAction func DodirniTipku(_ sender: UIButton) {
        
        let tipka = sender.currentTitle!
        
        if usredTipkanja {
           let trenutniDisplay = display.text!
            display.text = trenutniDisplay + tipka
        }else{
            display.text = tipka
            usredTipkanja = true
        }
    }
    
    //vrijednost na displayu
    var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    //kreiranje objekta brain
    private var brain = CalculatorBrain()
    
    //povezivanje operacija
    @IBAction func operation(_ sender: UIButton) {
        if usredTipkanja {
            brain.setOperand(displayValue)
            usredTipkanja = false
        }
        if let matSimbol = sender.currentTitle {
            brain.performOperation(matSimbol)
        }
        if let rezultat = brain.result{
            displayValue = rezultat
        }
    }
    
}

