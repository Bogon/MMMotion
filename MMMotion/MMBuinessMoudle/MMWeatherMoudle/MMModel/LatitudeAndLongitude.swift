//
//  LatitudeAndLongitude.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct LatitudeAndLongitude: Mappable {
    
    var lat: Float!
    var lon: Float!
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        lat <- map["lat"]
        lon <- map["lon"]
        
    }
}


