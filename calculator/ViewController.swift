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
        case Equal = "="
        case Empty = "Empty"
    }
    
    var currentOperation: Operation = Operation.Empty
    
   
    @IBOutlet weak var displayLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    
    var leftValueStr: String = ""
    
    var rightValueStr: String = ""
    
    var result: String = ""
    
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
        processOperation(Operation.Equal)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        initData()
        currentOperation = Operation.Empty
        updateDisplay()
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
                else{
                    result = runningNumber
                }
                
                leftValueStr = result
                displayLbl.text = result
            }
            else{
                result = leftValueStr
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
        if(currentOperation == Operation.Equal){
            initData()
            currentOperation = Operation.Empty
        }
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
    
    func initData() {
        runningNumber = ""
        leftValueStr = ""
        rightValueStr = ""
        result = "0"
        currentOperation = Operation.Empty
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
        
        initData()
        
        updateDisplay()
    }
}

