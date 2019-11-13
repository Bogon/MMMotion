//
//  CurrentConditions.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct CurrentConditions: Mappable {
    
    var city: City! // 城市信息
    
    var message: NSNumber! // System parameter, do not use it
    var cnt: Int!    // Number of lines returned by this API call
    var cod: Int!   // 状态码
    
    var list: [WeatherInfo]!
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        city <- map["city"]
        message <- map["message"]
        cnt <- map["cnt"]
        cod <- map["cod"]
        list <- map["list"]
   
    }
}
