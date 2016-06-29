//
//  ViewController.swift
//  calculator
//
//  Created by Hien Tran on 29/06/2016.
//  Copyright © 2016 HienTran. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation: Operation = Operation.Empty
    
    @IBOutlet weak var displayLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    
    var leftValueStr = ""
    
    var rightValueStr = ""
    
    var result = ""
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            if(runningNumber != ""){
                rightValueStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                }
                
                leftValueStr = result
                displayLbl.text = result
            }
            currentOperation = op
        }
        else{
            //This is the first time the operator is pressed
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        result = runningNumber
        //displayLbl.text = runningNumber
        updateDisplay()
    }
    
    func updateDisplay() {
        displayLbl.text = result
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        result = "0"
        updateDisplay()
    }
}

