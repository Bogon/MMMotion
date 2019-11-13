//
//  MMHuoXingWenResponseModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import ObjectMapper

/** 火星文的数据 */
public class MMHuoXingWenResponseModel: NSObject, Mappable {
    
    var reason: String?
    var result: String?
    var error_code: Int?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        reason              <- map["reason"]
        result              <- map["result"]
        error_code          <- map["error_code"]
    }
    
    override init() {
        super.init()
    }
    
}
