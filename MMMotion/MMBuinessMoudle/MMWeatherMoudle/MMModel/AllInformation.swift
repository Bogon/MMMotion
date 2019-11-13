//
//  AllInformation.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct AllInformation: Mappable {
    
    var latAndLon: LatitudeAndLongitude!
    var cityName: String!
    var cityId: Int!
    var population: Int!
    var base: String!  // 检测的站点
    var dt: NSNumber!
    var wind: Wind!
    var weaher: [Weather]!  // 天气信息列表
    var cloud: Clouds!
    var sys: Sys!
    var mainInfo: MainInfo!
    
    var cod: Int! // 状态码
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        latAndLon <- map["coord"]
        cityName <- map["name"]
        cityId <- map["id"]
        population <- map["id"]
        base <- map["base"]
        dt <- map["dt"]
        wind <- map["wind"]
        weaher <- map["weather"]
        cloud <- map["clouds"]
        sys <- map["sys"]
        mainInfo <- map["main"]
        
        cod <- map["cod"]
    }
}

