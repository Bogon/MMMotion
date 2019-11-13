//
//  NetWorking.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/22.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation
import Moya

class NetWorking {
    static let shared = { () -> MoyaProvider<NetworkService> in 
        let provider = MoyaProvider<NetworkService>()
        return provider
    }()
    
    private init() {
        
    }
}
