//
//  BeaconModel.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/13/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconModel {
    
    var UUID : UUID
    var majorValue : CLBeaconMajorValue
    var minorValue : CLBeaconMinorValue
    var beaconID : String
   
    
    init(UUID: UUID,majorValue: Int,minorValue: Int,beaconID: String) {
        self.UUID       = UUID
        self.majorValue = CLBeaconMajorValue(majorValue)
        self.minorValue = CLBeaconMinorValue(minorValue)
        self.beaconID   = beaconID
    }
    
}
