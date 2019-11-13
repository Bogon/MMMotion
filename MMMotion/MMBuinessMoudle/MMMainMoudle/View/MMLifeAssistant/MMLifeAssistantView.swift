//
//  MMLifeAssistantView.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MMLifeAssistantView: UIView {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var lav_imageview: UIImageView!
    @IBOutlet weak var lav_title_label: UILabel!
    @IBOutlet weak var lav_subtitle_label: UILabel!
    
    // MARK:- 创建视图
    class func instance() -> MMLifeAssistantView? {
        let nibView = Bundle.main.loadNibNamed("MMLifeAssistantView", owner: nil, options: nil)
        if let view = nibView?.first as? MMLifeAssistantView {
            view.backgroundColor = UIColor.white
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadow(view: self, width: 1, bColor: UIColor.init(hex: "#000000").alpha(0.05), sColor: UIColor.init(hex: "#000000").alpha(0.2), offset: CGSize.init(width: 0.5, height: 0.5), opacity: 1, radius: 15)
        
        let showsenvenTap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: nil)
        self.addGestureRecognizer(showsenvenTap)
        
        showsenvenTap.rx.event.subscribe(onNext: { recognizer in
            NotificationCenter.default.post(name: NSNotification.Name.gotoAI, object: nil, userInfo: nil)
        }).disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        self.lav_imageview.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(25)
            make.size.equalTo(CGSize.init(width: 80, height: 40))
        }

        self.lav_title_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.lav_imageview.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 120, height: 21))
        }

        self.lav_subtitle_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).offset(-25)
            make.top.equalTo(self.lav_title_label.snp.bottom).offset(5)
            make.height.equalTo(58)
        }
        
    }
    
    class func layoutSize() -> CGSize {
       
        let contentHeight: CGFloat = (UIScreen.ol_width - 30 - 15)/2.0
        return CGSize.init(width: contentHeight, height: contentHeight)
    }

}
