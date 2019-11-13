//
//  MMSportsNewsResposeModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import ObjectMapper

/** 历史上今天的数据 */
public class MMSportsNewsResposeModel: NSObject, Mappable {
    
    var reason: String?
    var result: MMSportsNewsListModel?
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

/** 体育新闻的某一条数据 */
class MMSportsNewsListModel: NSObject, Mappable {

    var stat: String? = ""
    var data: [MMSportsNewsModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        stat               <- map["stat"]
        data               <- map["data"]
    }
    
    override init() {
        super.init()
    }

}


/** 体育新闻的某一条数据 */
class MMSportsNewsModel: NSObject, Mappable {

    /*
       "uniquekey": "6c4caa0c3ba6e05e2a272892af43c00e",
                   "title": "杨幂的发际线再也回不去了么？网友吐槽像半秃",
                   "date": "2017-01-05 11:03",
                   "category": "yule",
                   "author_name": "腾讯娱乐",
                   "url": "http://mini.eastday.com/mobile/170105110355287.html?qid=juheshuju",
                   "thumbnail_pic_s": "http://03.imgmini.eastday.com/mobile/20170105/20170105110355_
           806f4ed3fe71d04fa452783d6736a02b_1_mwpm_03200403.jpeg",
                   "thumbnail_pic_s02": "http://03.imgmini.eastday.com/mobile/20170105/20170105110355_
           806f4ed3fe71d04fa452783d6736a02b_2_mwpm_03200403.jpeg",
                   "thumbnail_pic_s03": "http://03.imgmini.eastday.com/mobile/20170105/20170105110355_
           806f4ed3fe71d04fa452783d6736a02b_3_mwpm_03200403.jpeg"
        }
     */
    var ctime: String? = ""
    var author_name: String? = ""
    var title: String? = "-"
    var n_description: String? = ""
    var picUrl: String? = ""
    var url: String? = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ctime                       <- map["date"]
        title                       <- map["title"]
        author_name                 <- map["author_name"]
        n_description               <- map["title"]
        picUrl                      <- map["thumbnail_pic_s"]
        url                         <- map["url"]
    }
    
    override init() {
        super.init()
    }

}
