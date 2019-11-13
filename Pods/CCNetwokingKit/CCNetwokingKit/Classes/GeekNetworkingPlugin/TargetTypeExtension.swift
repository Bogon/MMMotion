//
//  TargetTypeExtension.swift
//  Pods
//
//  Created by mac on 2019/7/4.
//

import UIKit
import Moya

/// key
public extension TargetType {
    
    var cacheKey: String {
        
        let urlStr = baseURL.appendingPathComponent(path).absoluteString
        var sortParams = ""
        var parameter: [String: Any]?
        do{
            let json = try JSONSerialization.jsonObject(with: sampleData, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            parameter = dic
        } catch _ { return urlStr }
        
        guard let params = parameter else {
            return urlStr
        }
        /// sort
        let sortArr = params.keys.sorted { (str1, str2) -> Bool in
            return str1 < str2
        }
        for str1 in sortArr {
            
            if let value = params[str1] {
                if str1 == "longitude" ||  str1 == "latitude" {
                    sortParams = sortParams.appending("\(str1)=")
                } else {
                    sortParams = sortParams.appending("\(str1)=\(value)")
                }
            } else {
                
            }
        }
        return urlStr.appending("?\(sortParams)/\(appVersion!)/\(appBuildVersion!)")
    }
}
