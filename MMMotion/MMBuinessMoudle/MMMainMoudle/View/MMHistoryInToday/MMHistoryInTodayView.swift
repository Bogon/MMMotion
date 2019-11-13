//
//  MMHistoryInTodayView.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit

private let kDateFont: UIFont = UIFont.systemFont(ofSize: 14)
private let kContentFont: UIFont = UIFont.systemFont(ofSize: 14)

class MMHistoryInTodayView: UIView {

    @IBOutlet weak var hit_title_label: UILabel!
    @IBOutlet weak var hit_date_label: UILabel!
    @IBOutlet weak var hit_content_label: UILabel!
    
    var infoModel: MMHistoryInTodayInfoModel?
    
    // MARK:- 创建视图
    class func instance() -> MMHistoryInTodayView? {
        let nibView = Bundle.main.loadNibNamed("MMHistoryInTodayView", owner: nil, options: nil)
        if let view = nibView?.first as? MMHistoryInTodayView {
            view.backgroundColor = UIColor.init(hex: "#47B8AE")
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// 界面进行数据填充
    func setContent(_ valueModel: MMHistoryInTodayInfoModel) {
        self.infoModel = valueModel
        if valueModel.year == 0 {
            self.hit_date_label.text = "\(Date().getYearMonthDay())"
        } else {
            self.hit_date_label.text = "\(Date().getYearMonthDay()) 农历：\(valueModel.lunar!)"
        }
        
        if valueModel.des?.ol_length == 0 {
            self.hit_content_label.text = "\(valueModel.title!)"
        } else {
            self.hit_content_label.text = "\(valueModel.des!)"
        }
        
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let valueModel = self.infoModel else { return }
        
        self.hit_title_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.snp.top).offset(12)
            make.size.equalTo(CGSize.init(width: UIScreen.ol_width/2.0, height: 27))
        }
        
        self.hit_date_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.hit_title_label.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: UIScreen.ol_width - 30, height: 20))
        }
        
        var descriptionString: String = ""
        if valueModel.des?.ol_length == 0 {
            descriptionString = "\(valueModel.title!)"
        } else {
            descriptionString = "\(valueModel.des!)"
        }
        
        var descriptionSize: CGSize = "\(descriptionString) ".ol_sizeWithConstrainedWidth(UIScreen.ol_width - 24 - 30, font: kContentFont)
        descriptionSize.height += 2
        
        self.hit_content_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.hit_date_label.snp.bottom).offset(3)
            make.size.equalTo(descriptionSize)
        }
        
    }
    
    class func layoutHeight(WithModel valueModel: MMHistoryInTodayInfoModel) -> CGFloat {
        
        var descriptionString: String = ""
        if valueModel.des?.ol_length == 0 {
            descriptionString = "\(valueModel.title!)"
        } else {
            descriptionString = "\(valueModel.des!)"
        }
        
        var descriptionSize: CGSize = "\(descriptionString) ".ol_sizeWithConstrainedWidth(UIScreen.ol_width - 24, font: kContentFont)
        descriptionSize.height += 2
        
        let contentHeight: CGFloat = 12 + 27 + 5 + 20 + descriptionSize.height + 20
        return contentHeight
    }

}
