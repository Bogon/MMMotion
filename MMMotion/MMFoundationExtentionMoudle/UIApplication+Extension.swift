//
//  UIApplication+Extension.swift
//  perpetualCalendar
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// Avoid the error: [UIApplication sharedApplication] is unavailable in xxx extension
    ///
    /// - returns: UIApplication?
    public class func ol_sharedApplication() ->  UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: selector) else { return nil }
        return UIApplication.perform(selector).takeUnretainedValue() as? UIApplication
    }
    
    ///Get screen orientation
    public class var ol_screenOrientation: UIInterfaceOrientation? {
        guard let app = self.ol_sharedApplication() else {
            return nil
        }
        return app.statusBarOrientation
    }
    
    ///Get status bar's height
    @available(iOS 8.0, *)
    public class var ol_screenStatusBarHeight: CGFloat {
        guard let app = UIApplication.ol_sharedApplication() else {
            return 0
        }
        return app.statusBarFrame.height
    }
    
    /**
     Run a block in background after app resigns activity
     
     - parameter closure:           The closure
     - parameter expirationHandler: The expiration handler
     */
    public func ol_runIntoBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
    
    
   
}
