//
//  AppDelegate.swift
//  BeaconNotificationDemo
//
//  Created by Nafisa Rahman on 2/12/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //request authorization for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        //start communication between watch and iOS
        if WCSession.isSupported() {
            
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
        
        //background beacon monitoring
        if let key = launchOptions?.keys {
            
            if key.contains(.location) {
                
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestAlwaysAuthorization()
                locationManager.allowsBackgroundLocationUpdates = true
                locationManager.startUpdatingLocation()
                
            }
        }
        
        return true
     
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "proximity")
    }

}

//MARK:- Conform to WCSessionDelegate
extension AppDelegate : WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        print("watch session activated")
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
        print("watch session inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
        print("watch session ended")
        
    }
}
