//
//  BeaconViewModel.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/13/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation

@objc protocol ViewModelOperations : class {
    func updateUI(proximityValue: String)
    func getRegionState(state: String)
}

class BeaconViewModel {
    
    //MARK:- properties
    var beaconModel : BeaconModel
    //update UI protocol delegate
    weak var UIdelegate : UIOperation?
    var beaconHandler : BeaconHandler!
    let defaults = UserDefaults.standard
    
    //MARK:- Create BeaconHandler instance
    init(){
        
        //this should come from UI finally
        beaconModel = BeaconModel(UUID: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, majorValue: 10, minorValue: 46, beaconID: "MYBEACON")
        
        beaconHandler = BeaconHandler(beaconModel: beaconModel)
        
        //set delegate
        beaconHandler.viewModeldelegate = self
        
    }
    
    //MARK:- Create Beacon Region
    func createBeacon()  {
        
        beaconHandler.createBeaconRegion()
    }
    
    //
    func storeProximity(proximityValue: String) {
        
        defaults.set(proximityValue, forKey: "proximity")
    }
    
    func getProximity() -> String {
        
        var proximity = ""
        
        proximity = defaults.object(forKey: "proximity") as! String
        
        return proximity
    }
    
}

//MARK:- Conform to ViewModelOperations protocol
extension BeaconViewModel : ViewModelOperations {
    
    func updateUI(proximityValue: String) {
        
        //if proximity value matches previous value then don't update UI
        let prevProximity = getProximity()
        
        if prevProximity != proximityValue {
            
            storeProximity(proximityValue: proximityValue)
            UIdelegate?.updateLabel(UUID: "\(beaconModel.UUID)", majorValue: "\(beaconModel.majorValue)", minorValue: "\(beaconModel.minorValue)", beaconIdentifier: beaconModel.beaconID, proximityValue: proximityValue)
            
        }
        
    }
    
    func getRegionState(state: String) {
        
        print("getRegion state")
        
        UIdelegate?.sendNotification(title: "Beacon", beaconState: "\(state)")
    }
    
}


