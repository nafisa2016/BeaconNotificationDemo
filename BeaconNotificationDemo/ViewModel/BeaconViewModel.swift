//
//  BeaconViewModel.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/13/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation

@objc protocol ViewModelOperations : class {
    func sendNotification()
    func updateUI(proximityValue: String)
}

class BeaconViewModel {
    
    var beaconModel : BeaconModel
    
    //update UI protocol delegate
    weak var UIdelegate : UIOperation? 
    
    var beaconHandler : BeaconHandler!
    
    init(){
        
        //this should come from UI finally
        beaconModel = BeaconModel(UUID: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, majorValue: 10, minorValue: 46, beaconID: "MYBEACON")
        
        beaconHandler = BeaconHandler(beaconModel: beaconModel)
        
        //set delegate
        beaconHandler.viewModeldelegate = self
        
    }
    
    //
    func createBeacon()  {
        
        beaconHandler.createBeaconRegion()
    }
    
    
    
}

extension BeaconViewModel : ViewModelOperations {
    
    func updateUI(proximityValue: String) {
        
        UIdelegate?.updateLabel(UUID: "\(beaconModel.UUID)", majorValue: "\(beaconModel.majorValue)", minorValue: "\(beaconModel.minorValue)", beaconIdentifier: beaconModel.beaconID, proximityValue: proximityValue)
    }
    
    
    //
    func sendNotification() {
        
        UIdelegate?.sendNotification()
    }
    
}

 