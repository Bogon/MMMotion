//
//  WeatherInfo.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/29.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


struct WeatherInfo: Mappable {
    
    var weather: [Weather]! // Weather信息列表
    var temp: Temp!      // Temperature, Kelvin (subtract 273.15 to convert to Celsius)
    
    var clouds: Int!    // Cloudiness, %
    var humidity: Int!  // Humidity, %
    var dt: Int!        // Data receiving time, unix time, GMT
    var speed: NSNumber!     // Wind speed, mps
    var pressure: NSNumber!  // Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
    var deg: Int!       // Wind direction, degrees (meteorological)
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        weather <- map["weather"]
        temp <- map["temp"]
        clouds <- map["clouds"]
        humidity <- map["humidity"]
        dt <- map["dt"]
        speed <- map["speed"]
        pressure <- map["pressure"]
        deg <- map["deg"]
    }
}

