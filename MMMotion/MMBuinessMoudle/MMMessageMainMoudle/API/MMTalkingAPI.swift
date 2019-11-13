//
//  MMTalkingAPI.swift
//  MMPocket
//
//  Created by 张奇 on 2019/10/29.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import CCNetwokingKit
import SwifterSwift

enum MMTalkingAPI {
    
    /*************************************| 数据接口 |*********************************/
    case getTalking(value: [String: Any]?)                     /// 获取聊天的数据信息
}

extension MMTalkingAPI: TargetType {
    
    /// 网络请求头设置
    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
    
    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: "https://api.ownthink.com")!
    }
    
    /// 网络请求路径
    public var path: String {
        switch self {
        case .getTalking:
            return "/bot"
        }
    }
    
    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
        case .getTalking:
            return .get
        
        }
    }
    
    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
        case .getTalking(let value):
            return value
        
        }
    }
    
    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
        case .getTalking(let value):
            return value!.jsonData()!
        }
    }
    
    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .getTalking:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
       
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
        case .getTalking:
            return URLEncoding.queryString
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
