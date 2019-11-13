//
//  NetworkService.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case getWeatherInformation(lat: CGFloat, lon: CGFloat)
    case getCurrentConditions(lat: CGFloat, lon: CGFloat)

}

extension NetworkService: TargetType {
    var headers: [String : String]? {
        switch self {
        case .getWeatherInformation, .getCurrentConditions:
            return ["deviceType": "ios", "Content-Type" : "application/json; charset=utf-8"]
        default:
            return ["Content-Type" : "application/json; charset=utf-8"]
        }
    }
    
    
    /// The target's base `URL`.
    
    var baseURL: URL { return URL(string: "http://api.openweathermap.org")! }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getWeatherInformation:
            return "/data/2.5/weather"
        case .getCurrentConditions:
            return "/data/2.5/forecast/daily"
  
        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .getWeatherInformation, .getCurrentConditions:
            return .get
            
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getWeatherInformation(let lat, let lon), .getCurrentConditions(let lat, lon: let lon):
            return ["lat": lat, "lon": lon, "cnt": "14", "APPID": appIdKey]
     
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getWeatherInformation, .getCurrentConditions:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getWeatherInformation(let lat, let lon), .getCurrentConditions(let lat, let lon):
            return "\(lat), \(lon)".utf8Encoded
       
        }
        
        
    }
    
    var task: Task {
        switch self {
        case .getWeatherInformation, .getCurrentConditions:
            //request 就是访问一个网址， 还有下载和上传其他枚举类型  一般用于比较大的
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

