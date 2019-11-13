//
//  PressAnimationButton.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/31.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

@objc protocol PressAnimationButtonDelegate: NSObjectProtocol {
    
    @objc func finishedEventWith(button: PressAnimationButton)
}

class PressAnimationButton: UIButton {
    
    weak var delegate: PressAnimationButtonDelegate?
    
    /**
     *  动画结束 + 恢复正常的时间
     */
    var toEndDuration: TimeInterval = 0
    var toNormalDuration: TimeInterval = 0

    var animationWidth: CGFloat = 0 // 动画的宽度
    
    // 显示用的view
    lazy private var showView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        
        // 创建出showView
        createShowView()
        
        // 给 button 添加事件
        addButtonTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addButtonTarget() {
        
        // 按住按钮后没有松手的动画
        self.addTarget(self, action: #selector(buttonTouchDownAndDragEnter), for: [.touchDown, .touchDragEnter])
        
        // 按住按钮松手后的动画
        self.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        
        // 按住按钮后拖拽出去的动画
        self.addTarget(self, action: #selector(buttonTouchDragExit), for: .touchDragExit)
    }
    
    // 按住按钮后没有松手的动画事件
    @objc private func buttonTouchDownAndDragEnter() {
        
        showView.bounds = showView.layer.presentation()?.bounds ?? CGRect.zero
        showView.alpha = CGFloat(showView.layer.presentation()?.opacity ?? 0)
        
       // self.titleLabel?.alpha =
//        self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
//        self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
        
        // 移除之前的动画状态
        self.showView.layer.removeAllAnimations()
        
        UIView.animate(withDuration: toEndDuration <= 0 ? 0.5 : toEndDuration, animations: { 
            
            self.showView.bounds = CGRect(x: 0, y: 0, width: 1000, height: self.animationWidth <= 0 ? 1000 : self.animationWidth)
            self.showView.alpha = 1
            //
            //            //            self.normalLabel.alpha    = 0.f;
            //            //            self.highlightLabel.alpha = 1.f;
            
        }) { (finished) in
            
            if finished == true {
                if self.delegate != nil && self.delegate!.responds(to: #selector(self.delegate!.finishedEventWith(button:))){
                    
                    self.delegate?.finishedEventWith(button: self)
                }
            }
        }
    }

    
    
    // 按住按钮松手后的动画事件
    @objc private func buttonTouchUpInside() {
        
        showView.bounds = showView.layer.presentation()?.bounds ?? CGRect.zero
        showView.alpha = CGFloat(showView.layer.presentation()?.opacity ?? 0)
        
        
//        self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
//        self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
        
        // 移除之前的动画状态
        self.showView.layer.removeAllAnimations()
        
        UIView.animate(withDuration: toNormalDuration <= 0 ? 0.35 : toNormalDuration, animations: { 
            
            self.showView.bounds = CGRect(x: 0, y: 0, width: 1000, height: 0)
            self.showView.alpha  = 0
            
//            self.normalLabel.alpha    = 1.f;
//            self.highlightLabel.alpha = 0.f;
            
        }) { (_) in
            
        }

    }
    
    // 按住按钮后拖拽出去的动画事件
    @objc private func buttonTouchDragExit() {
        
        showView.bounds = showView.layer.presentation()?.bounds ?? CGRect.zero
        showView.alpha = CGFloat(showView.layer.presentation()?.opacity ?? 0)
        
        
        //        self.normalLabel.alpha    = ((CALayer *)self.normalLabel.layer.presentationLayer).opacity;
        //        self.highlightLabel.alpha = ((CALayer *)self.highlightLabel.layer.presentationLayer).opacity;
        
        // 移除之前的动画状态
        self.showView.layer.removeAllAnimations()
        
        UIView.animate(withDuration: toNormalDuration <= 0 ? 0.35 : toNormalDuration, animations: {
            
            self.showView.bounds = CGRect(x: 0, y: 0, width: 1000, height: 0)
            self.showView.alpha  = 0
            
            //            self.normalLabel.alpha    = 1.f;
            //            self.highlightLabel.alpha = 0.f;
            
        }) { (_) in
            
        }
    }
    
    // showView相关
    private func createShowView() {
        
        showView.frame = CGRect(x: 0, y: 0, width: 1000, height: 0)
        self.addSubview(showView)
        
        showView.alpha  = 0
        showView.center = self.center
        
        showView.transform = CGAffineTransform(rotationAngle: 45 * CGFloat.pi / 180)
        showView.backgroundColor = UIColor.red
        showView.isUserInteractionEnabled = false
        self.showView.isUserInteractionEnabled = false

        
    }

    
    func setAnimationColor(color: UIColor) {
        showView.backgroundColor = color
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
