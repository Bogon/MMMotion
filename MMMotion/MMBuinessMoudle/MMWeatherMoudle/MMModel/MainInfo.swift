//
//  MainInfo.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//
import Foundation
import Moya
import ObjectMapper

struct MainInfo: Mappable {
    var temp: NSNumber!
    var pressure: NSNumber!
    var humidity: NSNumber!
    var temp_min: NSNumber!
    var temp_max: NSNumber!
    var sea_level: NSNumber!
    var grnd_level: NSNumber!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
        sea_level <- map["sea_level"]
        grnd_level <- map["grnd_level"]
    }
}

