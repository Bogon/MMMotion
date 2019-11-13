//
//  WeatherInfoDAL.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import CoreGraphics

//数据模型访问层
class WeatherInfoDAL {
    
    //得到当天的天气信息
    class func getAllInformation(lat: CGFloat, lon: CGFloat, completion: @escaping (_ allInformation: AllInformation?, _ isSucceed: Bool) -> Void) {
        NetWorking.shared.request(.getWeatherInformation(lat: lat, lon: lon)) { (result) in
            
            switch result {
            case let .success(moyaResponse):
                
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                
                if let jsonResponse = AllInformation(JSON: json){
                    completion(jsonResponse, true)
                }
                
            case .failure:
                completion(nil, false)
                
            }
        }
    }
    
    //得到未来几天的天气信息
    class func getCurrentConditions(lat: CGFloat, lon: CGFloat, completion: @escaping (_ currentConditions: CurrentConditions?, _ isSucceed: Bool) -> Void) {
        NetWorking.shared.request(.getCurrentConditions(lat: lat, lon: lon)) { (result) in
            
            switch result {
            case let .success(moyaResponse):
                
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                
                if let jsonResponse = CurrentConditions(JSON: json){
                    completion(jsonResponse, true)
                }
                
            case .failure:
                completion(nil, false)
                
            }
        }
    }
    
    
}
