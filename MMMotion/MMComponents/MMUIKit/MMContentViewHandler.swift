//
//  MMContentViewHandler.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/3.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import UIKit

class MMContentViewHandler {
    
    internal static let shared = MMContentViewHandler()
    private init() {}
    
    /// 快速创建一个ContnetView
    func getContentView() -> UIView {
        return UIView()
    }
    
    /// 快速创建一个ContnetTableView
    func getContentTableView(_ delegate: UIViewController, style: UITableView.Style = .plain) -> UITableView {
        let contentTableView: UITableView = UITableView.init(frame: CGRect.zero, style: style)
        contentTableView.delegate = (delegate as! UITableViewDelegate)
        contentTableView.dataSource = (delegate as! UITableViewDataSource)
        return contentTableView
    }
}
