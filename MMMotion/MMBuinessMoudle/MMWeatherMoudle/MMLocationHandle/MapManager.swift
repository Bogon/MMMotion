//
//  MapManager.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/28.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import CoreLocation

@objc protocol MapManagerLocationDelegate: NSObjectProtocol {
    @objc optional func mapDidUpdateAndGetLastCLLocation(manager: MapManager, location: CLLocation)
    
    @objc optional func mapDidFailed(manager: MapManager, error: Error)
    
    @objc optional func mapManagerServerClosed(manager: MapManager)
}

class MapManager: NSObject, CLLocationManagerDelegate {
    
    //定位标识符，用于判断是否第一次接收到location
    var locationFlag: Bool = true
    
    static let shared: MapManager = MapManager()
    
    weak var delegate: MapManagerLocationDelegate?
    
    private var locationManager: CLLocationManager? = nil
    
    //CLAuthorizationStatus: 这些常数表示应用程序是否被授权使用位置服务。
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    private override init() {
        
    }
    
    func start() {
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if (locationManager?.responds(to: #selector(locationManager?.requestWhenInUseAuthorization)))! {
            locationManager?.requestWhenInUseAuthorization()
        }

        locationManager?.startUpdatingLocation()
        
    }
    
    //MARK: - 代理方法
    // Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        manager.stopUpdatingLocation()
        guard locationFlag == true else {
            return
        }
        if (delegate != nil) && delegate!.responds(to: #selector(delegate!.mapDidUpdateAndGetLastCLLocation(manager:location:))) {
            
            let location: CLLocation = locations.last!
            delegate!.mapDidUpdateAndGetLastCLLocation!(manager: self, location: location)
        }
        locationFlag = false
     
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        print("定位失败")
        
        if CLLocationManager.locationServicesEnabled() == false {
            print("定位功能关闭")
            if delegate != nil && delegate!.responds(to: #selector(delegate!.mapManagerServerClosed(manager:))) {
                delegate!.mapManagerServerClosed!(manager: self)
            }
        }else {
            print("定位功能开启")
            if delegate != nil && delegate!.responds(to: #selector(delegate!.mapDidFailed(manager:error:))) {
                print(error)
                delegate?.mapDidFailed!(manager: self, error: error)
            }
        }
    }
    
}
