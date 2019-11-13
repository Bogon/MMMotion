//
//  Sun.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/21.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class Sun: UIView {
    
//    var upCenterRect: CGRect = CGRect.zero
//    var downCenterRect: CGRect = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let sunwidth  = self.frame.size.width
//        let sunheight = self.frame.size.height / 2.0
        
//        self.upCenterRect   = CGRect(x: 0, y: 0, width: sunwidth, height: sunheight)
//        self.downCenterRect = CGRect(x: 0, y: sunheight, width: sunwidth, height: sunheight)
    }
    
    
    //显示动画
    func cshowWithDuration(duration: TimeInterval) {
        
    }

    //隐藏动画
//    func hideWithDuration(duration: TimeInterval) {
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
