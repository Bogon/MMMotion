//
//  MMHuoXingWenTransferAPIViewModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/11/10.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import ObjectMapper
import CCNetwokingKit
import Moya

private let key: String = "9f92c7e040fb4d7ca10bbb0369fccf06"
private let changeType: Int = 2     /// 1、中文 2、繁体   3、 火星文

class MMHuoXingWenTransferAPIViewModel {
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<MMHuoXingWenTransferAPI>(manager: GeekSecurityCertificationProvider.manager(), plugins: [])
    
    internal static let shared = MMHuoXingWenTransferAPIViewModel()
    private init() {}
    
    /*******************************************| START - 生活助手 - START |*************************************/
    /// 火星文转换接口
    ///
    /// - Parameter value: 必填字段：v
    /// - Returns: 今日信息数据Model
    func getHuoXingWenTransfer(WithCache isCache: Bool, text: String) -> Promise<MMHuoXingWenResponseModel> {
        return Promise { seal in
            let value: [String: String] = ["changeType": "\(changeType)", "key": key, "content": text]
            provider.requestJson(.getHUoXingWenTransfer(value: value), isCache: isCache)
                .mapObject(type:MMHuoXingWenResponseModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
}

