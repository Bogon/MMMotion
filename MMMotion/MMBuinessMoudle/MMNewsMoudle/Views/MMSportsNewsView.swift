//
//  MMSportsNewsView.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit
import SDWebImage

class MMSportsNewsView: UIView {

    @IBOutlet weak var snv_imageview: UIImageView!
    @IBOutlet weak var snv_title_label: UILabel!
    @IBOutlet weak var snv_time_label: UILabel!
    @IBOutlet weak var line: UIView!
    
    var model: MMSportsNewsModel?
    
    // MARK:- 创建视图
    class func instance() -> MMSportsNewsView? {
        let nibView = Bundle.main.loadNibNamed("MMSportsNewsView", owner: nil, options: nil)
        if let view = nibView?.first as? MMSportsNewsView {
            view.backgroundColor = UIColor.white
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.snv_imageview)
        
    }
    
    func setContent(WithModel infoModel: MMSportsNewsModel) {
        self.model = infoModel
        self.snv_title_label.text = infoModel.title ?? "-"
        self.snv_time_label.text = infoModel.ctime ?? "-"
        self.snv_imageview.sd_setImage(with: URL.init(string: infoModel.picUrl ?? ""), placeholderImage: UIImage.init(named: "news_placeholder"), options: .refreshCached, completed: nil)
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let infoModel = self.model else { return  }
        
//        self.snv_imageview.snp.remakeConstraints { (make) in
//            make.centerY.equalTo(self.snp.centerX)
//            make.left.equalTo(self.snp.left).offset(12)
//            make.size.equalTo(CGSize.init(width: 145, height: 100))
//        }

        
        /// 描述
        var des_Size: CGSize = "\(infoModel.n_description!) ".ol_sizeWithConstrainedWidth(UIScreen.ol_width - 12 - 145 - 10 - 12, font: UIFont.systemFont(ofSize: 15))
        des_Size.height += 2
        self.snv_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snv_imageview.snp.right).offset(5)
            make.top.equalTo(self.snv_imageview.snp.top)
            make.size.equalTo(des_Size)
        }
        
        self.snv_time_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snv_imageview.snp.right).offset(5)
            make.bottom.equalTo(self.snv_imageview.snp.bottom)
            make.size.equalTo(CGSize.init(width: UIScreen.ol_width/2.0, height: 15))
        }
        
        self.line.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snv_imageview.snp.left)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(0.5)
        }
        
    }
    
    class func layoutHeight() -> CGFloat {
       
        let contentHeight: CGFloat = 120
        return contentHeight
    }

}
