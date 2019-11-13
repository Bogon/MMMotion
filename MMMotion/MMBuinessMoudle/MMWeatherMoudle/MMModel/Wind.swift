//
//  Wind.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct Wind: Mappable {
    
    var speed: NSNumber! // Wind speed, mps
    var deg: NSNumber!   // Wind direction, degrees (meteorological)
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        speed <- map["speed"]
        deg <- map["deg"]
        
    }
}
