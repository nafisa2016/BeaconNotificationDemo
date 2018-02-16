//
//  ViewController.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/12/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import UIKit
import CoreLocation

@objc protocol UIOperation : class {
    func sendNotification()
    func updateLabel(UUID: String,majorValue : String,minorValue : String, beaconIdentifier: String,proximityValue: String)
}

class ViewController: UIViewController{
    
    
    @IBOutlet weak var UUIDValueLbl: UILabel!
    
    @IBOutlet weak var majorValueLbl: UILabel!
    @IBOutlet weak var minorValueLbl: UILabel!
    
    @IBOutlet weak var beaconID: UILabel!
    @IBOutlet weak var proximityValueLbl: UILabel!
    
    //view model
    lazy var beaconViewModel = BeaconViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set delegate
        beaconViewModel.UIdelegate = self
        
        
        
        //create beacon
        beaconViewModel.createBeacon()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UIOperation {
    
    func sendNotification() {
        
        print("notification ")
        
    }
    func updateLabel(UUID: String,majorValue : String,minorValue : String, beaconIdentifier: String,proximityValue: String) {
        
        print("update UI")
        
        UUIDValueLbl.text = UUID
        majorValueLbl.text = majorValue
        minorValueLbl.text = minorValue
        beaconID.text = beaconIdentifier
        proximityValueLbl.text = proximityValue
        
    }
}



