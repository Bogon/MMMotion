//
//  NSDate+Extension.swift
//  TSWeChat
//
//  Created by Hilen on 2/22/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation

public extension Date {
    static var milliseconds: TimeInterval {
        get { return Date().timeIntervalSince1970 * 1000 }
    }
    
    var millisecond: TimeInterval {
        get { return self.timeIntervalSince1970 * 1000 }
    }

    /** 当前时间的整点: 2019年03月12日 */
    func getYearMonthDay() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return "\(convertedDate0)"
    }
    
    /** 当前时间的日: 25 */
    func getDay() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return convertedDate0
    }
    
    /** 当前时间的月: 25 */
    func getMonth() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return convertedDate0
    }
    
    /** 当前时间的整点: 04/25 */
    func getFlashDate() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return convertedDate0
    }
    
    /** 当前时间的整点: 04月25 */
    func getMMDDDate() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return convertedDate0
    }
    
    /** 当前时间的整点: 04月25 */
    func getHHMMDate() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return convertedDate0
    }
    
    /** 当前时间的整点: 2019-03-12 12:00 */
    func getFullTime() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return "\(convertedDate0):00"
    }
    
    /** 当前时间的整点前一个小时: 2019-03-12 12:00 */
    func getLastHourFullTime() -> String {
         let lasthourDay: Date = NSDate.init(timeInterval: -60*60, since: self) as Date
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: lasthourDay)
        //输出转换结果
        return "\(convertedDate0):00"
    }
    
    /** 当前时间的整点: 2019-03-12 00:00 */
    func getStartFullTime() -> String {
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //调用string方法进行转换
        let convertedDate0 = dateFormatter.string(from: self)
        //输出转换结果
        return "\(convertedDate0) 00:00"
    }
    
    func week() -> String {
        let myWeekday: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: self).weekday!
        switch myWeekday {
        case 1:
            return "周日"
        case 2:
            return "周一"
        case 3:
            return "周二"
        case 4:
            return "周三"
        case 5:
            return "周四"
        case 6:
            return "周五"
        case 7:
            return "周六"
        default:
            break
        }
        return ""
    }
    
    /** 当前日期是这一年的第几周 */
    func getWeekInYear() -> String {
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return ""
        }
        let components = calendar.components([.weekOfYear,.weekOfMonth,.weekday,.weekdayOrdinal], from: self)
        //今年的第几周
        let weekOfYear = components.weekOfYear!
        
        //这个月第几周
        let weekOfMonth = components.weekOfMonth!
        //周几
        let weekday = components.weekday!
        //这个月第几周
        let weekdayOrdinal = components.weekdayOrdinal!
        return "第\(components.weekOfYear!)周";
    }
    
    /** 根据公历年、月、日获取对应的农历日期信息 */
    func solarToLunar() -> String {
        /// 初始化公历日历
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)
        
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!).substring(from: 5)
    }

    
    static func messageAgoSinceDate(_ date: Date) -> String {
        return self.timeAgoSinceDate(date, numericDates: false)
    }
    
    static func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy年MM月dd日"
            return "\(dformatter.string(from: date))"
            ///return "\(components.year!) 年前"
        } else if (components.year! >= 1){
            if (numericDates){
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy年MM月dd日"
                return "\(dformatter.string(from: date))"
                ///return "1 年前"
            } else {
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy年MM月dd日"
                return "\(dformatter.string(from: date))"
                ///return "去年"
            }
        } else if (components.month! >= 2) {
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM月dd日"
            return "\(dformatter.string(from: date))"
            ///return "\(components.month!) 月前"
        } else if (components.month! >= 1){
            if (numericDates){
                let dformatter = DateFormatter()
                dformatter.dateFormat = "MM月dd日"
                return "\(dformatter.string(from: date))"
                ///return "1 个月前"
            } else {
                let dformatter = DateFormatter()
                dformatter.dateFormat = "MM月dd日"
                return "\(dformatter.string(from: date))"
                //return "上个月"
            }
        } else if (components.weekOfYear! >= 2) {
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM月dd日 HH:mm"
            return "\(dformatter.string(from: date))"
            ///return "\(components.weekOfYear!) 周前"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                let dformatter = DateFormatter()
                dformatter.dateFormat = "MM月dd日 HH:mm"
                return "\(dformatter.string(from: date))"
                ///return "1 周前"
            } else {
                let dformatter = DateFormatter()
                dformatter.dateFormat = "MM月dd日 HH:mm"
                return "\(dformatter.string(from: date))"
                ///return "上一周"
            }
        } else if (components.day! >= 2) {
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM月dd日 HH:mm"
            return "\(dformatter.string(from: date))"
            ///return "\(components.day!) 天前"
        } else if (components.day! >= 1){
            if (numericDates){
                let dformatter = DateFormatter()
                dformatter.dateFormat = "MM月dd日 HH:mm"
                return "\(dformatter.string(from: date))"
                //                return "1 天前"
            } else {
                let dformatter = DateFormatter()
                dformatter.dateFormat = "HH:mm"
                return "昨天 \(dformatter.string(from: date))"
            }
        } else if (components.hour! >= 2) {
            ///return "\(components.hour!) 小时前"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        } else if (components.hour! >= 1){
            //return "1 小时前"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        } else if (components.minute! >= 2) {
            ///return "\(components.minute!) 分钟前"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        } else if (components.minute! >= 1){
            ///return "1 分钟前"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        } else if (components.second! >= 3) {
            ///return "\(components.second!) 秒前"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        } else {
            //return "刚刚"
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm"
            return "今天 \(dformatter.string(from: date))"
        }
    }
    
    /*
    static func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) 年前"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 年前"
            } else {
                return "去年"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) 月前"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 个月前"
            } else {
                return "上个月"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) 周前"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 周前"
            } else {
                return "上一周"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) 天前"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 天前"
            } else {
                return "昨天"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) 小时前"
        } else if (components.hour! >= 1){
            return "1 小时前"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) 分钟前"
        } else if (components.minute! >= 1){
            return "1 分钟前"
        } else if (components.second! >= 3) {
            return "\(components.second!) 秒前"
        } else {
            return "刚刚"
        }
    } */
}
