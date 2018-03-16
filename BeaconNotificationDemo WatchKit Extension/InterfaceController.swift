//
//  InterfaceController.swift
//  BeaconNotificationDemo WatchKit Extension
//
//  Created by Nafisa Rahman on 2/12/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    let session = WCSession.default
    
    @IBOutlet var proximityLbl: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveProximity), name: NSNotification.Name(rawValue: "ReceivedProximity"), object: nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @objc func didReceiveProximity(info: Notification){
        
        let proximity = info.userInfo!
        proximityLbl.setText(proximity["Proximity"] as? String)
    }
    
}


