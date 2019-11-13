//
//  Clouds.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct Clouds: Mappable {
    
    var all: Int!
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        all <- map["all"]

        
    }
}

