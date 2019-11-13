//
//  Model.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct City: Mappable {

    var latAndLon: LatitudeAndLongitude!
    var cityName: String!
    var cityId: Int!
    var population: Int!
    var country: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        latAndLon <- map["coord"]
        cityName <- map["name"]
        cityId <- map["id"]
        population <- map["population"]
        country <- map["country"]
        
    }
}

