//
//  Sys.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct Sys: Mappable {
    
    var message: NSNumber!           // System parameter, do not use it
    var country: String!  // Country (GB, JP etc.)
    var sunset: Int!   // Sunrise time, unix, UTC
    var sunrise: Int!  // Sunset time, unix, UTC
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        country <- map["country"]
        sunset <- map["sunset"]
        sunrise <- map["sunrise"]
        
    }
}
