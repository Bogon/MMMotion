//
//  FadeBlackView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/26.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class FadeBlackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        self.alpha = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        UIView.animate(withDuration: 1.0) { 
            self.alpha = 0.75
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.75) {
            self.alpha = 0.0
        }
    }

}
