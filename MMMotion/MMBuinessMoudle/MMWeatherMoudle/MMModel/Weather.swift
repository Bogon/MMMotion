//
//  Weather.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct Weather: Mappable {
    
    var weatherId: Int!
    var main: String!            // Group of weather parameters (Rain, Snow, Extreme etc.)
    var icon: String!            // Weather icon id
    var description: String!
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        weatherId <- map["id"]
        main <- map["main"]
        icon <- map["icon"]
        description <- map["description"]
        
    }
}



