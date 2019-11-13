//
//  weather-Bridging-Header.h
//  weather
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

#ifndef weather_Bridging_Header_h
#define weather_Bridging_Header_h

/// 该区域作为桥接文件区，其主要作用：1、将使用Objective-C创建的类和文件在OC中进行使用，需要在此处引入其头文件
//        2、如下引入HUD，和Base64加解密框架

/// 加解密
#import <CommonCrypto/CommonDigest.h>

/// HUD提示框
#import "MBProgressHUD+DZM.h"


#endif /* weather_Bridging_Header_h */
