//
//  MMWeatherInfoView.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MMWeatherInfoView: UIView {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var wiv_imageview: UIImageView!
    @IBOutlet weak var wiv_title_label: UILabel!
    
    // MARK:- 创建视图
    class func instance() -> MMWeatherInfoView? {
        let nibView = Bundle.main.loadNibNamed("MMWeatherInfoView", owner: nil, options: nil)
        if let view = nibView?.first as? MMWeatherInfoView {
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
            NotificationCenter.default.post(name: NSNotification.Name.seeWeatherInfo, object: nil, userInfo: nil)
        }).disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        self.wiv_imageview.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }

        self.wiv_title_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize.init(width: 120, height: 21))
        }
        
    }
    
    class func layoutSize() -> CGSize {
       
        let contentHeight: CGFloat = (UIScreen.ol_width - 30 - 15)/2.0
        return CGSize.init(width: contentHeight, height: contentHeight)
    }


}
