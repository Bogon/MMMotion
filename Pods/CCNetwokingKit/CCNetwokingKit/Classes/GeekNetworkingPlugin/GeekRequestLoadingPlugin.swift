//
//  GeekRequestLoadingPlugin.swift
//  Alamofire
//
//  Created by mac on 2019/7/4.
//

import Foundation
import Moya
import Result

enum GeekResponseCodeType: Int {
    case timeout                = 401    /// 请求超时
    case noneAuthentication     = 403    /// 未授权
    case accessTokenTimeout     = 426    /// token time out
}

/// show or hide the loading hud
final class GeekRequestLoadingPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        /// show loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = true       /// 显示状态栏网络请求小菊花
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // hide loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = false      /// 隐藏状态栏网络请求小菊花
        //        switch result {
        //        case .success(let response):
        //            let status: Int = response.statusCode
        //            if 401 == status {      /// 超时
        //                cowCloudRefreshAccessTokenModel.shared.refreshAccessToken()
        //            } else if 426 == status {   ///  需要重新授权
        //                MBProgressHUD.showError("请重新登录")
        //            }
        //            log.info("response.request = \(response.request!)")
        //            //log.info("response.response = \(response.response!)")
        //        case .failure(let error):
        //            log.error("error = \(error)")
        //            break
        //
        //        }
    }
    
}

// network logger
public final class NetworkLogger: PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {
        /// show loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = true       /// 显示状态栏网络请求小菊花
    }
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // hide loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = false      /// 隐藏状态栏网络请求小菊花
        //          #if DEBUG
        //                switch result {
        //                case .success(let response):        /// case .success(let response):
        //                    log.info("\ncurrent request URL: \(response.request!)  \n request Status: Request Successful!!!")
        //                    break
        //                case .failure(let error):
        //                    log.error("\(error)")
        //                    break
        //
        //                }
        //          #endif
    }
}

/// AccessTokenPlugin
public final class AccessTokenPlugin: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let authorizable = target as? AccessTokenAuthorizable else {
            return request
        }
        var request = request
        switch authorizable.authorizationType {
        case .basic:
            request.addValue("Basic eHVlYmFPTFN0dWRlbnQ6YWlsZHk2NjY=", forHTTPHeaderField: "Authorization")
        case .bearer:
            /// add Basic header  - OAuth2 需要对数据进行重新认证
            let bearerValue: String  = UserDefaults.standard.string(forKey: "kAccessToken") ?? "5ab927f3-f181-47ff-9501-d0314123123c55"
            request.addValue("Bearer \(bearerValue)", forHTTPHeaderField: "Authorization")
        case .none:
            break;
        case .custom(_):
            break;
        }
        return request
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    
    init (configuration: URLSessionConfiguration, inMemoryCapacity: Int, diskCapacity: Int, diskPath: String?) {
        configuration.urlCache = URLCache(memoryCapacity: inMemoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}
