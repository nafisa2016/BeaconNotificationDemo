//
//  ViewController.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/12/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@objc protocol UIOperation : class {
    func updateLabel(UUID: String,majorValue : String,minorValue : String, beaconIdentifier: String,proximityValue: String)
    func sendNotification(title:String,beaconState: String)
}

class ViewController: UIViewController{
    
    //MARK:- Outlets and declarations
    @IBOutlet weak var UUIDValueLbl: UILabel!
    @IBOutlet weak var majorValueLbl: UILabel!
    @IBOutlet weak var minorValueLbl: UILabel!
    @IBOutlet weak var beaconID: UILabel!
    @IBOutlet weak var proximityValueLbl: UILabel!
    
    //view model
    lazy var beaconViewModel = BeaconViewModel()

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set delegate
        beaconViewModel.UIdelegate = self
        UNUserNotificationCenter.current().delegate = self
        
        //MARK: Create beacon
        beaconViewModel.createBeacon()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//MARK:- Conform to UIOperation protocol
extension ViewController : UIOperation {
    
    //MARK: update UI with beacon details
    func updateLabel(UUID: String,majorValue : String,minorValue : String, beaconIdentifier: String,proximityValue: String) {
        
        UUIDValueLbl.text = UUID
        majorValueLbl.text = majorValue
        minorValueLbl.text = minorValue
        beaconID.text = beaconIdentifier
        proximityValueLbl.text = proximityValue
        
        if !proximityValue.isEmpty {
            sendNotification(title: "Beacon Proximity",beaconState: "proximity = \(proximityValue)")
        }
        
    }
    
    //MARK:- Send notification
    func sendNotification(title:String,beaconState: String) {
        
        print("notification ")
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = beaconState
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        
        let request = UNNotificationRequest(identifier: "BeaconNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            }
        }
        
    }
}

//MARK:- Conform to UNUserNotificationCenterDelegate
extension ViewController : UNUserNotificationCenterDelegate {
    
    //MARK: Present notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.badge,.sound])
    }
    
}



