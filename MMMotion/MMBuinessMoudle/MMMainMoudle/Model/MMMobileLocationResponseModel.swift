//
//  MMMobileLocationResponseModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/4.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import ObjectMapper

/** 手机号码所在地的数据 */
public class MMMobileLocationResponseModel: NSObject, Mappable {
    
    var resultcode: String?
    var reason: String?
    var result: MMMobileLocationInfoModel?
    var error_code: Int?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        reason              <- map["reason"]
        resultcode          <- map["resultcode"]
        result              <- map["result"]
        error_code          <- map["error_code"]
    }
    
    override init() {
        super.init()
    }
    
}

/** 手机号码所在地一条数据 */
class MMMobileLocationInfoModel: NSObject, Mappable {

    /*
     "province":"北京",
     "city":"北京",
     "areacode":"010",
     "zip":"100000",
     "company":"移动",
     "card":""
     */
    var province: String? = ""
    var city: String? = "无今日历史信息"
    var areacode: String? = ""
    var zip: String? = ""
    var company: String? = ""
    var card: String? = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        province             <- map["province"]
        city                 <- map["city"]
        areacode             <- map["areacode"]
        zip                  <- map["zip"]
        company              <- map["company"]
        card                 <- map["card"]
        
    }
    
    override init() {
        super.init()
    }

}
