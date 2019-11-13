//
//  MMHistoryInTodayResponseModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import ObjectMapper

/** 历史上今天的数据 */
public class MMHistoryInTodayResponseModel: NSObject, Mappable {
    
    var reason: String?
    var result: [MMHistoryInTodayInfoModel]?
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
    
    /** 历史上今天的数据 */
    var infoValue: [MMHistoryInTodayInfoModel]? {
        guard let historyInfo = result else {
            return [MMHistoryInTodayInfoModel()]
        }
        
        if historyInfo.count == 0 {
            return [MMHistoryInTodayInfoModel()]
        }
        return historyInfo
    }
    
}

/** 历史上今天的某一条数据 */
class MMHistoryInTodayInfoModel: NSObject, Mappable {

    /*
     "_id":"20101001m2",
     "title":"西安大明宫国家遗址公园开园",
     "pic":"http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201110/2/6D83516539.jpg",
     "year":2010,
     "month":10,
     "day":1,
     "des":"2010年10月1日 (农历八月廿四)，西安大明宫国家遗址公园开园。",
     "lunar":"庚寅年八月廿四"
     */
    var _id: String? = ""
    var title: String? = "无今日历史信息"
    var pic: String? = ""
    var year: Int? = 0
    var month: Int? = 0
    var day: Int? = 0
    var des: String? = ""
    var lunar: String? = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id             <- map["_id"]
        title           <- map["title"]
        pic             <- map["pic"]
        year            <- map["year"]
        day             <- map["day"]
        month           <- map["month"]
        des             <- map["des"]
        lunar           <- map["lunar"]
    }
    
    override init() {
        super.init()
    }

}
