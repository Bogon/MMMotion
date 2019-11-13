//
//  Temp.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct Temp: Mappable {
    
    var min: NSNumber!  // Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
    var max: NSNumber!  // Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally)
    
    var morn: NSNumber!  // 早晨
    var day: NSNumber!   // 白天
    var night: NSNumber! // 下午
    var eve: NSNumber!   // 午夜
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        day <- map["day"]
        min <- map["min"]
        max <- map["max"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
        
    }
}
