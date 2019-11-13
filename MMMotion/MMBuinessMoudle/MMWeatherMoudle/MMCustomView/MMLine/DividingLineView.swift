//
//  DividingLineView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/28.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

//分割线view
class DividingLineView: UIView {

    var maxAlpha: CGFloat = 0.5
    var fadeToShowDuration: TimeInterval = 0
    var fadeToHideDuration: TimeInterval = 0
    
    var startFrame: CGRect?
    var midFrame: CGRect?
    var endFrame: CGRect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let x = frame.origin.x
        let y = frame.origin.y
        
        let height = frame.size.height
        let width = frame.size.width
        
        startFrame = CGRect(x: x, y: y, width: 0, height: height)
        midFrame = CGRect(x: x, y: y, width: width, height: height)
        endFrame = CGRect(x: x + width, y: y, width: 0, height: height)
        
        self.frame = self.startFrame!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        UIView.animate(withDuration: fadeToShowDuration) {
            self.alpha = self.maxAlpha
            self.frame = self.midFrame!
        }
    }
    
    func hide() {
        UIView.animate(withDuration: self.fadeToHideDuration, animations: { 
            self.alpha = 0
            self.frame = self.endFrame!
        }) { (_) in
            self.frame = self.startFrame!
            self.alpha = 0
        }
    }

}
