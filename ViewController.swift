//
//  ViewController.swift
//  hello-mhealth
//
//  Created by Alaina Kafkes on 1/18/16.
//  Copyright © 2016 Alaina Kafkes. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import CoreMotion // to access CoreMotion framework

class ViewController: UIViewController{
    
    //Instance Variables
    
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    // for thresh
    var thresholdVal: Double = 3.0;
    
    var movementManager = CMMotionManager()
    // how I access motion sensors (comes from CoreMotion)
    
    //Outlets
    
    @IBOutlet var accX: UILabel!
    @IBOutlet var accY: UILabel!
//    @IBOutlet var accZ: UILabel!
    @IBOutlet var maxAccX: UILabel!
    @IBOutlet var maxAccY: UILabel!
//    @IBOutlet var maxAccZ: UILabel!
    
    // Colors?
    @IBOutlet var HelloLabel: UILabel!
//    @IBOutlet var WorldLabel: UILabel!
    
    
    // for thresh
    @IBOutlet weak var newThresh: UITextField!
    @IBOutlet weak var inputter: UIButton!
    
    // Setting up Firebase?
    let ref = Firebase(url: "https://fiery-inferno-9226.firebaseio.com/")
    
    
    @IBAction func resetMaxValues(sender: AnyObject) {

        currentMaxAccelX = 0
        currentMaxAccelY = 0
    }
    
    override func viewDidLoad() {
        
        HelloLabel.textColor = UIColor.redColor()
//        WorldLabel.textColor = UIColor.redColor()
        
        
        //RESET
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
        // Set Motion Manager Properties
        movementManager.gyroUpdateInterval = 0.2
        movementManager.accelerometerUpdateInterval = 0.2
        
        // Start Recording Data
        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
        movementManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
//            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
            
            
        })

        
    }
    
    // for thresh
    func convertInput(text: String) -> Double {
        if text != "" {
            var result = Int(text);
            var newResult = Double(result!);
            //inputter.enabled = true;
            return newResult;
        }
        
        else {
            return thresholdVal;
        }
    }
    
    @IBAction func updateThresh(sender: AnyObject) {
        thresholdVal = convertInput(newThresh.text!);
    }
    
    @IBAction func updateGreeting(sender: UILabel) {
        //ref.setValue(sender.titleLabel?.text)
        ref.setValue(HelloLabel.text)
    }
    
    func outputAccData(acceleration: CMAcceleration){
        
        accX?.text = "\(acceleration.x).2fg"
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        accY?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        if fabs(currentMaxAccelX) >= thresholdVal {
//            HelloLabel.textColor = UIColor.blueColor()
//            WorldLabel.textColor = UIColor.clearColor()
            
            ref.observeEventType (.Value, withBlock: { snapshot in
                self.HelloLabel.text = "hello"
                //self.HelloLabel.text = snapshot.value as? String
            })
            
            ref.updateChildValues(["greeting": "hello"]);
            
        }
        
        if fabs(currentMaxAccelX) < thresholdVal {
//            HelloLabel.textColor = UIColor.clearColor()
//            WorldLabel.textColor = UIColor.blueColor()
            ref.observeEventType(.Value, withBlock: {
                snapshot in
                self.HelloLabel.text = "world"
            })
            
            ref.updateChildValues(["greeting": "world"]);
            
        }
        
        maxAccX?.text = "\(currentMaxAccelX).2f"
        maxAccY?.text = "\(currentMaxAccelY).2f"
        
        
    }
    
    
    
}

