//
//  BeaconHandler.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/13/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconHandler : NSObject {
    
    //MARK:- Properties
    var locationManager : CLLocationManager!
    var beaconModel : BeaconModel?
    var beaconRegion: CLBeaconRegion!
    
    var beaconProximity = ""
    weak var viewModeldelegate : ViewModelOperations?
    
    //MARK:- initialize
    override init(){
        
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
    }
    
    convenience init(beaconModel: BeaconModel) {
        
        self.init()
        self.beaconModel = beaconModel
    }
    
    //MARK:- Create Beacon Region
    func createBeaconRegion(){
        
        if CLLocationManager.isMonitoringAvailable(for:
            CLBeaconRegion.self) {
            
            guard let beaconModel = beaconModel else {
                print("beacon not available")
                return
            }
            
            // Create the region and begin monitoring it.
            beaconRegion = CLBeaconRegion(proximityUUID: beaconModel.UUID,
                                          identifier: beaconModel.beaconID)
            self.locationManager.startMonitoring(for: beaconRegion)
        }
    }
    
    //MARK:- Get Beacon proximity
    func getBeaconProximity(proximity: CLProximity){
        
        switch proximity {
            
        case .far:
            print("beacon is far")
            beaconProximity = "Far"
        case .immediate:
            print("beacon is immediate")
            beaconProximity = "immediate"
        case .near:
            print("beacon is near")
            beaconProximity = "near"
        case .unknown:
            print("beacon unknown")
            beaconProximity = "unknown"
            
        }
        
    }
    
}

//MARK:- Conform to CLLocationManagerDelegate
extension BeaconHandler : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("beacon entered: \(region)")
        viewModeldelegate?.setRegionState(state: "Inside beacon region")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        print("beacon exit: \(region)")
        viewModeldelegate?.setRegionState(state: "Outside Beacon Region")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        locationManager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        if state == .inside {
            locationManager.startRangingBeacons(in: beaconRegion)
        } else {
            locationManager.stopRangingBeacons(in: beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        if beacons.count > 0 {
            
            getBeaconProximity(proximity: beacons[0].proximity)
            
            viewModeldelegate?.updateUI(proximityValue: beaconProximity)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
        print("failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        
        print("failed: \(error)")
    }
}
