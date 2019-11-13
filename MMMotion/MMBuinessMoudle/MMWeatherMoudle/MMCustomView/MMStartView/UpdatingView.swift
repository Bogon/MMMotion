//
//  UpdatingView.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/26.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class UpdatingView: UIView {

    lazy private var label: GlowLabel = GlowLabel()  // 标题
    private var labelStoreValue: CGRectStoreValue = CGRectStoreValue() // 标题存储值
    
    lazy private var failedLabel: GlowLabel = GlowLabel() // 失败标签
    private var failedLabelStoreValue: CGRectStoreValue = CGRectStoreValue() // 失败存储值
    
    lazy var snow: SnowView = SnowView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.0, height: UIScreen.main.bounds.width / 2.0))   // 下雪
    private var snowStoreValue: CGRectStoreValue = CGRectStoreValue()   // 下雪存储值
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLabel()
        initSnow()
        
        // 关闭用户交互
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLabel() {
        
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.width / 2.0, width: UIScreen.main.bounds.width / 2.0, height: 20.0)
        self.addSubview(label)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: LATO_LIGHT, size: 18.0)
        label.text = "Updating . . ."
        
        label.gcdTimerInterval = 0.8
        label.glowDuration     = 0.7
        label.glowLayerOpacity = 1
        
        label.createGlowLayerWithColor(color: UIColor.white, glowRadius: 2)
        label.startGlow()

        labelStoreValue.midRect = label.frame
        label.frame.origin.x -= 20.0
        labelStoreValue.startRect = label.frame
        label.frame.origin.x += 60.0
        labelStoreValue.endRect = label.frame
        label.frame = labelStoreValue.startRect
        label.alpha = 0.0

        failedLabel.frame = CGRect(x: 0, y: UIScreen.main.bounds.width / 2.0, width: UIScreen.main.bounds.width / 2.0, height: 20.0)
        self.addSubview(failedLabel)
        failedLabel.textColor = UIColor.white
        failedLabel.textAlignment = .center
        failedLabel.font = UIFont(name: LATO_LIGHT, size: 24.0)
        failedLabel.text = "Failed"
    
        failedLabel.gcdTimerInterval = 0.8
        failedLabel.glowDuration     = 0.7
        failedLabel.glowLayerOpacity = 1
        failedLabel.createGlowLayerWithColor(color: UIColor.red, glowRadius: 2)
        failedLabel.startGlow()

        failedLabelStoreValue.midRect = failedLabel.frame
        failedLabel.frame.origin.x -= 30.0
        failedLabelStoreValue.startRect = failedLabel.frame
        failedLabel.frame.origin.x += 60.0
        failedLabelStoreValue.endRect = failedLabel.frame
        failedLabel.frame = failedLabelStoreValue.startRect
        failedLabel.alpha = 0.0

    }
    
    func initSnow() {
        
        self.addSubview(snow)
        snow.snowImage = #imageLiteral(resourceName: "snow")
        snow.birthRate = 20.0
        snow.gravity = 5.0
        snow.snowColor = UIColor.white
        snow.layer.mask = CALayer.createMaskLayerWithSize(size: CGSize(width: UIScreen.main.bounds.width / 2.0, height: UIScreen.main.bounds.width / 2.0), maskPNGImage: #imageLiteral(resourceName: "alpha"))
        snow.showSnow()
        snow.transform = CGAffineTransform(a: 1.4, b: 0, c: 0, d: 1.4, tx: 0, ty: 0)
        snow.alpha = 0.0

    }
    
    func insertIntoView(view: UIView) {
        
    }
    
    func show() {
        
        UIView.animate(withDuration: 1.0, animations: { 
            self.snow.alpha = 1.0
            self.snow.transform = CGAffineTransform(a: 1.0, b: 0, c: 0, d: 1.0, tx: 0, ty: 0)
            
            self.label.frame = self.labelStoreValue.midRect
            self.label.alpha = 1.0
        }) { (_) in
            
        }

    }
    
    func hide() {
        UIView.animate(withDuration: 0.75, animations: { 
            self.snow.alpha = 0.0
            self.snow.transform = CGAffineTransform(a: 0.7, b: 0, c: 0, d: 0.7, tx: 0, ty: 0)
            
            self.label.frame = self.labelStoreValue.endRect
            self.label.alpha = 0.0
            
            self.failedLabel.frame = self.failedLabelStoreValue.endRect
            self.failedLabel.alpha = 0.0
        }) { (_) in
            
            self.label.frame = self.labelStoreValue.startRect
            self.snow.transform = CGAffineTransform(a: 1.4, b: 0, c: 0, d: 1.4, tx: 0, ty: 0)
            self.failedLabel.frame = self.failedLabelStoreValue.startRect
        }

    }
    
    func showFailed() {
        
        UIView.animate(withDuration: 1.5, animations: {
            // 隐藏label标签
            self.label.frame = self.labelStoreValue.endRect
            self.label.alpha = 0.0
        }) { (_) in
            
            UIView.animate(withDuration: 1.0, animations: { 
                // 显示failed标签
                self.failedLabel.frame = self.failedLabelStoreValue.midRect
                self.failedLabel.alpha = 1.0
                
            }, completion: { (_) in
                
            })
        }
    }

}
