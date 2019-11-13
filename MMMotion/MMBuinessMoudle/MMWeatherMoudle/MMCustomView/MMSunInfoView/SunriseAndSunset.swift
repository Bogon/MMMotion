//
//  SunriseAndSunset.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation

class SunriseAndSunset {
    
    // 获取到的UTC时间
    var utcSec: TimeInterval = 0
    
    // 时间字符串
    var timeString: String = ""
    
    //时间格式
    private var formatter: DateFormatter?
    
    init() {
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "HH : mm"
    }
    
    //开始处理时间信息
    func accessUtcSec() {
        // Unix UTC
        let seconds: TimeInterval = (self.utcSec <= 0 ? 0 : self.utcSec)
      
        // 获取到了UTC时间
        let utcDate: Date = Date.init(timeIntervalSince1970: seconds)

        // 设置时间格式
        self.timeString = (self.formatter?.string(from: utcDate))!
    }
    
}
