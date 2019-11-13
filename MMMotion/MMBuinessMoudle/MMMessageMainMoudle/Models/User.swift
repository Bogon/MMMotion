//
//  User.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit
import Foundation

class User: MSGUser {

    var displayName: String = ""
    var avatar: UIImage?
    var avatarUrl: URL?
    var isSender: Bool = false
    var isFunction: Bool = false
    
    required init(displayName: String, avatar: UIImage?, avatarUrl: URL?, isSender: Bool, isFunction: Bool) {
        self.displayName = displayName
        self.avatar = avatar
        self.avatarUrl = avatarUrl
        self.isSender = isSender
        self.isFunction = isFunction
    }
    
}
