//
//  MMSportsNewsViewCell.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit

class MMSportsNewsViewCell: UITableViewCell {

    /// 资讯信息
    var sportsNewsView: MMSportsNewsView = MMSportsNewsView.instance()!
    
    /// 资讯信息
    var infoModel: MMSportsNewsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addSubview(self.sportsNewsView)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
    }
    
    func setContent(WithSportsNews infoModel: MMSportsNewsModel) {
        self.infoModel = infoModel
        self.sportsNewsView.setContent(WithModel: infoModel)
        
        
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let _ = self.infoModel else { return  }
        
        /// 开始主内容布局
        self.sportsNewsView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.top.equalTo(self.contentView.snp.top)
            make.size.equalTo(CGSize.init(width: UIScreen.ol_width, height: MMSportsNewsView.layoutHeight()))
        }
        
    }
    
    class func layoutHeight() -> CGFloat {
        return MMSportsNewsView.layoutHeight()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
