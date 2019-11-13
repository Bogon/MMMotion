//
//  MBProgressHUD+DZM.m
//
//  Created by DZM on 16-6-6.
//  Copyright 2016年  All rights reserved.
//
#import <mach/mach_types.h>
#import "MBProgressHUD+DZM.h"
#import "UIColor+Hex.h"

#define HUDlabelColor [UIColor colorWithHex:0xffffff]
#define HUDColorAlpha 0.7
@implementation MBProgressHUD (DZM)
#pragma mark 显示信息
+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    hud.labelText = text;
    hud.labelTextColor = HUDlabelColor;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
    return hud;
}

+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view yOffset:(CGFloat)yOffset {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [self show:text icon:icon view:view];
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    hud.yOffset = yOffset;
    hud.labelTextColor = HUDlabelColor;
    return hud;
}

+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view yOffset:(CGFloat)yOffset completion:(MBProgressHUDCompletionBlock)completionBlock {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [self show:text icon:icon view:view yOffset:yOffset];
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    hud.completionBlock = completionBlock;
    hud.labelTextColor = HUDlabelColor;
    return hud;
}

#pragma mark 显示错误信息
+ (MBProgressHUD *)showError:(NSString *)error {
    return [self showError:error toView:nil];
}

+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *)view{

    return [self show:error icon:@"error1.png" view:view];
}

+ (void)showError:(NSString *)error completion:(MBProgressHUDCompletionBlock)completionBlock {
    [self showError:error toView:nil completion:completionBlock];
}

+ (void)showError:(NSString *)error toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completionBlock {
    [self show:error icon:@"error1.png" view:view yOffset:0 completion:completionBlock];
}

#pragma mark - 显示成功信息
+ (MBProgressHUD *)showSuccess:(NSString *)success {
    return [self showSuccess:success toView:nil];
}

+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *)view {
    return [self show:success icon:@"success1.png" view:view];
}

+ (void)showSuccess:(NSString *)success completion:(MBProgressHUDCompletionBlock)completionBlock {
    [self show:success icon:@"success1.png" view:nil yOffset:0 completion:completionBlock];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completionBlock {
    [self show:success icon:@"success1.png" view:view yOffset:0 completion:completionBlock];
}

#pragma mark - 显示提示消息

+ (void)showHitMessage:(NSString *)hitMessage {
    [self showHitMessage:hitMessage toView:nil];
}

+ (void)showHitMessage:(NSString *)hitMessage yOffset:(CGFloat)yOffset {
    [self showHitMessage:hitMessage toView:nil yOffset:yOffset];
}

+ (void)showHitMessage:(NSString *)hitMessage toView:(UIView *)view {
    [self showHitMessage:hitMessage toView:view yOffset:0];
}

+ (void)showHitMessage:(NSString *)hitMessage toView:(UIView *)view yOffset:(CGFloat)yOffset {
    [self show:hitMessage icon:nil view:view yOffset:yOffset completion:nil];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    hud.labelText = message;
    hud.labelTextColor = HUDlabelColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showTextMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    hud.labelText = message;
    hud.labelTextColor = HUDlabelColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showMessageToView:(UIView *)view {
    return [self showMessage:nil toView:view];
}

+ (MBProgressHUD *)showMessage {
    return [self showMessage:nil toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (nonnull MBProgressHUD *)showTextMessage:(NSString *_Nullable)message {
    return [self showTextMessage:message toView:nil];
}

#pragma mark - 小菊花(activityIndicator) 可设置进行阻拦  默认 不进行阻拦
+ (void)showAI {
    [self showAIToView:nil];
}

+ (void)showAIYOffset:(CGFloat)yOffset {
    [self showAIToView:nil yOffset:yOffset];
}

+ (void)showAIToView:(UIView *)view {
    [self showAIToView:view enabled:NO];
}

+ (void)showAIToView:(UIView *)view enabled:(BOOL)enabled {
    
    [self showAIToView:view yOffset:0 enabled:enabled];
}

+ (void)showAIToView:(UIView *)view yOffset:(CGFloat)yOffset {
    [self showAIToView:view yOffset:yOffset enabled:NO];
}

+ (void)showAIToView:(UIView *)view yOffset:(CGFloat)yOffset enabled:(BOOL)enabled {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 先隐藏一遍
    [MBProgressHUD hideHUDForView:view];
    // 创建菊花
    UIActivityIndicatorView *ai = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ai.color = HUDlabelColor;
    [ai startAnimating];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showCustomView:ai toView:view];
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    // 偏移位置
    hud.yOffset = yOffset;
    hud.labelTextColor = HUDlabelColor;
    // 是否可以交互
    hud.userInteractionEnabled = enabled;
}

#pragma mark - 隐藏信息

+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

#pragma mark - 设置自定义view
+ (MBProgressHUD *)showCustomView:(UIView *)customView toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 先隐藏一遍
    [MBProgressHUD hideHUDForView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor colorWithHex:0x111111 andAlpha:HUDColorAlpha];
    hud.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    hud.layer.shadowRadius = 20;
    hud.layer.shadowOpacity = 1;
    hud.layer.shadowOffset = CGSizeMake(0, 10);
    // 设置图片
    hud.customView = customView;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelTextColor = HUDlabelColor;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
@end
