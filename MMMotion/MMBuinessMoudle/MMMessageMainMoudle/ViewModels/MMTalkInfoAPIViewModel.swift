//
//  MMTalkInfoAPIViewModel.swift
//  MMPocket
//
//  Created by 张奇 on 2019/10/29.
//  Copyright © 2019 Bogon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import PromiseKit
import ObjectMapper
import CCNetwokingKit
import Moya

class MMTalkInfoAPIViewModel {
    
    private let disposeBag = DisposeBag()
    private let provider:MoyaProvider = MoyaProvider<MMTalkingAPI>(manager: GeekSecurityCertificationProvider.manager(), plugins: [])
    
    internal static let shared = MMTalkInfoAPIViewModel()
    private init() {}
    
    /*******************************************| START - 生活助手 - START |*************************************/
    /// 生活聊天信息接口
    ///
    /// - Parameter value: 必填字段：spoken
    /// - Returns: 当天数据Model
    func getTalkingInfo(WithParameters value: [String: Any], isCache: Bool) -> Promise<MMTalkingInfomationResponseModel> {
        return Promise { seal in
            provider.requestJson(.getTalking(value: value), isCache: isCache)
                .mapObject(type:MMTalkingInfomationResponseModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }
}

