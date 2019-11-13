//
//  AnimatedLineView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/17.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class AnimatedLineView: UIView {

    private var startRect: CGRect = CGRect.zero
    private var midRect: CGRect = CGRect.zero
    private var endRect: CGRect = CGRect.zero
    
    //显示的图片
    var image = UIImage() {
        didSet{
            imageView.image = image
        }
    }
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initRects()
        
        imageView = UIImageView(frame: startRect)
        imageView.alpha = 0.0
        self.addSubview(imageView)
        
    }
    
    //重置UIImageView的参数
    func resetImageView() {
        imageView.alpha = 0.0
        imageView.frame = startRect
    }
    
    //显示出来
    func showWithDuration(duration: TimeInterval, animated: Bool) {
        
        resetImageView()
        
        if animated {
            
            UIView.animate(withDuration: duration, animations: { 
                self.imageView.frame = self.midRect
                self.imageView.alpha = 1.0
            })
        }else {
            
            self.imageView.frame = self.midRect
            self.imageView.alpha = 1.0
        }
        
    }
    
    //隐藏
    func hideWithDuration(duration: TimeInterval, animated: Bool) {
        
        if animated {
            
            UIView.animate(withDuration: duration, animations: {
                self.imageView.frame = self.endRect
                self.imageView.alpha = 0.0
            })
        }else {
            
            self.imageView.frame = self.endRect
            self.imageView.alpha = 0.0
        }
        
    }
    
    func initRects() {
        let width = self.bounds.width
        let height = self.bounds.height / 2.0
        
        self.startRect = CGRect(x: 0, y: -10, width: width, height: height)
        self.midRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.endRect = CGRect(x: 0, y: -5, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
