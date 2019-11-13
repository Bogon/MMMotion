//
//  GeekDataKitMacro.swift
//  Pods
//
//  Created by mac on 2019/7/4.
//

import Foundation

var GeekBaseNewsURL: String {
    get {
        #if DEBUG
        return "http://106.75.3.64/newsapi/newspoolV2"
        #else
        return "http://newsapicom.dftoutiao.com/newsapi/newspoolV2"
        #endif
    }
}
var GeekBaseNewsTimescampURL: String {
    get {
        #if DEBUG
        return "http://123.59.142.180/newskey/ts"
        #else
        return "http://newsapicom.dftoutiao.com/newskey/ts"
        #endif
    }
}

var GeekBasedURL: String {
    #if DEBUG
    //    return "http://172.16.11.16:8923"                            //开发环境
    return "http://testweatapi.hellogeek.com"                      //测试环境
    //    return "http://172.16.11.10:8923"                            //预发环境
    #elseif TEST
    return "http://testweatapi.hellogeek.com"
    #elseif UAT
    return "http://preweatapi.hellogeek.com"
    #else
    return "http://weatapi.weather188.com"               /// http://weatapi.hellogeek.com
    #endif
}

/// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

/// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
/// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
/// 屏幕bounds
let kScreenBounds = UIScreen.main.bounds

/// 网络连接状态
extension NSNotification.Name {
    /// 网络已连接
    public static let connected: NSNotification.Name = Notification.Name("connectedEvent")
    /// 网络不可用
    public static let unreachable: NSNotification.Name = Notification.Name("unreachableEvent")
}


///app build版本号
let appBuildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
///app 版本号
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
