//
//  MMNewsController.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit

class MMNewsController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {

    /// 体育资讯的数据源
    var dataArray: [MMSportsNewsModel]? = [MMSportsNewsModel]()
    
    /// 天气表单
    lazy var contentTableView: UITableView = {
        var contentTableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return contentTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getSportsNews()
    }
    

    /// 获取首页数据
    func getSportsNews() {
        
        weak var weakSelf = self
        MMNewsAPIViewModel.shared.getNews(WithCache: true).done { (respose) in
             guard let strongSelf = weakSelf else { return }
            strongSelf.dataArray = respose.result?.data
            strongSelf.contentTableView.reloadData { }
        }.catch { (error) in
            
        }
    }

}
