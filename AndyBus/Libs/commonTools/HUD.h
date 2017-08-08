//
//  HUD.h
//  HomeWork
//
//  Created by gfsh on 14-10-13.
//  Copyright (c) 2014年 Gao Fusheng. All rights reserved.
//

#import "SVProgressHUD.h"

@interface HUD : SVProgressHUD

+ (SVProgressHUD*)sharedView;

+ (void)loading;

+ (void)loading1;

+ (void)loadingWithStatus:(NSString *)status;

+ (void)hide;

+ (void)success:(NSString *)str;

+ (void)warning:(NSString *)str;

+ (void)error:(NSString *)str;

+ (void)showHUDPorgress:(float)progress status:(NSString *)status;
@end
