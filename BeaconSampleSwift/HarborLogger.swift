//
//  HarborLogger.swift
//  BeaconSampleSwift
//
//  Created by Scott Matheson on 11/30/18.
//  Copyright © 2018 HarborIO, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import CoreLocation
import HarborBeacon

// From your Harbor acount page
// API Key
let API_KEY   = "YOUR_ORGANIZATION_API_KEY_GOES_HERE"

// From your Harbor acount page
// App Version ID
let APP_ID    = "io.hrbr.samples.halfwaterglass:1.0.0"

// From your Harbor acount page
// Beacon Version ID
let BEACON_ID = "io.hrbr.iosswift:0.9.0"

enum HarborUIApplicationDelegateMessage: String {
  case start = "APP_START_MSG"
  case bg    = "APP_BG_MSG"
  case fg    = "APP_FG_MSG"
  case kill  = "APP_KILL_MSG"
}

enum HarborViewLifecycleMessage: String {
  case view  = "SCREEN_VIEW"
  case dwell = "SCREEN_DWELL"
}

let HEARTBEAT = "HEARTBEAT"

let GEOLOCATION = "GEOLOCATION"

class HarborLogger {

  // MARK: - Accessors
  
  static func log(_ messageType: String) {
    HarborLogger.log(messageType, data: [:])
  }
  
  static func log(_ messageType: String, data:[String:Any]!) {
    print("Sending \(messageType)")
    let dataOut = data ?? [:]
    BeaconQueue.shared().transmit(messageType, data : dataOut, apiKey: API_KEY, appVer : APP_ID, beaconVer : BEACON_ID)
  }
  
  // MARK: - Heartbeat Functionality
  
  static var hbTimer: Timer?
  
  public static func sendHeartbeat(){
    HarborLogger.log(HEARTBEAT)
  }

  public static func startHeartbeat(_ heartbeatsPerMinute: Int = 1){
    HarborLogger.beginHeartbeat(heartbeatsPerMinute: heartbeatsPerMinute)
  }
  
  public static func beginHeartbeat(heartbeatsPerMinute: Int = 1){
    HarborLogger.stopHeartbeat()
    let interval = 60.0 / Double(heartbeatsPerMinute)
    hbTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true){ _ in
      HarborLogger.sendHeartbeat()
    }
  }
  
  public static func stopHeartbeat(){
    hbTimer?.invalidate()
  }

  // MARK: - View Lifecycle Functionality

  static var dwellTimers: [String:TimeInterval] = [:]
  
  public static func startScreenDwell(_ screenName: String ){
    let data = [ "screen": screenName ] 
    HarborLogger.dwellTimers[screenName] = Date().timeIntervalSince1970
    HarborLogger.log(HarborViewLifecycleMessage.view.rawValue, data: data)
  }
  
  public static func stopScreenDwell( _ screenName: String ) {
    if let startTime = HarborLogger.dwellTimers.removeValue(forKey: screenName) {
      let dwellTime = String(Date().timeIntervalSince1970 - startTime)
        
        print(dwellTime)
        let data = [ "time": dwellTime, "screen": screenName ] 
      HarborLogger.log(HarborViewLifecycleMessage.dwell.rawValue, data: data)
    } else {
      print ("Attempt to stop a screen dwell timer called \(screenName) that does not exist")
    }
  }

  // MARK: - UIApplicationDelegate Functionality
  
  public static func appStart(){
    HarborLogger.log(HarborUIApplicationDelegateMessage.start.rawValue)
  }
  
  public static func appBackground(){
    HarborLogger.log(HarborUIApplicationDelegateMessage.bg.rawValue)
  }
  
  public static func appForeground(){
    HarborLogger.log(HarborUIApplicationDelegateMessage.fg.rawValue)
  }
  
  public static func appKill(){
    HarborLogger.log(HarborUIApplicationDelegateMessage.kill.rawValue)
  }

  // MARK: - CLLocation Functionality

  public static func logLocation(_ location: CLLocation ){
    let data = ["latitude":     "\(location.coordinate.latitude)",
        "longitude":    "\(location.coordinate.longitude)",
        "altitude":     "\(location.altitude)",
        "hz_accuracy":  "\(location.horizontalAccuracy)",
        "vrt_accuracy": "\(location.verticalAccuracy)" ]
    HarborLogger.log(GEOLOCATION, data: data)
  }

}
