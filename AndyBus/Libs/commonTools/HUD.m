//
//  HUD.m
//  HomeWork
//
//  Created by gfsh on 14-10-13.
//  Copyright (c) 2014年 Gao Fusheng. All rights reserved.
//

#import "HUD.h"

@implementation HUD

+ (void)loading
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor colorWithRed:102.0/255 green:169.0/255 blue:167.0/255 alpha:1.0]];
    [self showWithMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)loading1
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor colorWithRed:102.0/255 green:169.0/255 blue:167.0/255 alpha:1.0]];
    [self showWithMaskType:SVProgressHUDMaskTypeNone];
    [self setStatus:@"正在加载"];
}
+ (void)loadingWithStatus:(NSString *)status{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor colorWithRed:102.0/255 green:169.0/255 blue:167.0/255 alpha:1.0]];
    [self showWithMaskType:SVProgressHUDMaskTypeClear];
    [self setStatus:status];
}

+ (void)hide
{
    [self dismiss];
}

+ (void)success:(NSString *)str
{
    [self defaultSetting];
    [self showSuccessWithStatus:str maskType:SVProgressHUDMaskTypeClear];
}

+ (void)warning:(NSString *)str
{
    [self defaultSetting];
    [self showImage:[UIImage imageNamed:@"3【系统公用】警告提示_icon1"] status:str maskType:SVProgressHUDMaskTypeClear];
}

+ (void)error:(NSString *)str
{
    [self defaultSetting];
    [self showImage:[UIImage imageNamed:@"3【系统公用】警告提示_icon2"] status:str maskType:SVProgressHUDMaskTypeClear];
}

+ (void)defaultSetting
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor whiteColor]];
}

+ (void)showHUDPorgress:(float)progress status:(NSString *)status{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor colorWithRed:102.0/255 green:169.0/255 blue:167.0/255 alpha:1.0]];
    [self showProgress:progress status:status maskType:SVProgressHUDMaskTypeClear];
}

@end
