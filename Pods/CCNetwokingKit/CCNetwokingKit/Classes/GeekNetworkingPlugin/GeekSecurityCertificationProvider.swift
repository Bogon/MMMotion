//
//  UITableView+NibExtention.swift
//  perpetualCalendar
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import Foundation
import Moya
import Alamofire


public class GeekSecurityCertificationProvider {
    
    public static let shared = GeekSecurityCertificationProvider()
    private init() {}
    /// https头部信息的provider
    public static func manager() -> Manager {
        //使用Alamofire的直接使用manager做请求
        let manager: Alamofire.SessionManager = {
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 10 // timeout
            configuration.httpMaximumConnectionsPerHost = 50
            let manager = Alamofire.SessionManager(configuration: configuration)
            manager.adapter = CustomRequestAdapter()
            
            manager.delegate.sessionDidReceiveChallenge = { session, challenge in
                var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
                var credential: URLCredential?
                
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                    disposition = URLSession.AuthChallengeDisposition.useCredential
                    credential = URLCredential(trust: challenge.protectionSpace.serverTrust! )
                } else {
                    if challenge.previousFailureCount > 0 {
                        disposition = .cancelAuthenticationChallenge
                    } else {
                        credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                        
                        if credential != nil {
                            disposition = .useCredential
                        }
                    }
                }
                return (disposition, credential)
            }
            return manager
        }()
        return manager
    }
    
    // request adpater to add default http header parameter
    private class CustomRequestAdapter: RequestAdapter {
        public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            urlRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            return urlRequest
        }
    }
    
}
