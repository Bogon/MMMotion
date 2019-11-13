//
//  GCDGroup.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import Foundation

class GCDGroup: NSObject {
    
    var dispatchGroup: DispatchGroup?
    
    override init() {
        
        self.dispatchGroup = DispatchGroup()
        super.init()
    }
    
}
