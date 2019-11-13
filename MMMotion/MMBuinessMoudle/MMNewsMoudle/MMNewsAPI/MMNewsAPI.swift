//
//  MMNewsAPI.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import CCNetwokingKit
import SwifterSwift

enum MMNewsAPI {
    
    /*************************************| 数据接口 |*********************************/
    case getSportsNews(value: [String: Any]?)     /// 获取体育新闻的数据信息
}

extension MMNewsAPI: TargetType {
    
    /// 网络请求头设置
    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
    
    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: "http://v.juhe.cn")!
    }
    
    /// 网络请求路径
    public var path: String {
        switch self {
        case .getSportsNews:
            return "/toutiao/index"
        }
    }
    
    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
        case .getSportsNews:
            return .get
        
        }
    }
    
    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
        case .getSportsNews(let value):
            return value
        
        }
    }
    
    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
        case .getSportsNews(let value):
            return value!.jsonData()!
        }
    }
    
    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .getSportsNews:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
       
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
        case .getSportsNews:
            return URLEncoding.queryString
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
