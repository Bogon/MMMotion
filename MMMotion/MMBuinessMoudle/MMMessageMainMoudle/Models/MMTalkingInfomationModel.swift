//
//  MMTalkingInfomationModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/10/29.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import ObjectMapper

/** 只能聊天的数据 */
public class MMTalkingInfomationResponseModel: NSObject, Mappable {
    
    var message: String?
    var data: [String: Any]?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        message         <- map["msg"]
        data            <- map["data"]
    }
    
    override init() {
        super.init()
    }
    
    /** 返回聊天的数据 */
    var talkValue: String? {
        guard let realtimeInfo = data else {
            return "不明白你在说什么…"
        }
        
        guard let info  = realtimeInfo["info"] else {
            return "不明白你在说什么…"
        }
        
        let infoValue: [String: Any] = info as!  [String: Any]
        guard let talkInfo = infoValue["text"] else {
            return "不明白你在说什么…"
        }
        return (talkInfo as! String)
    }
    
}
