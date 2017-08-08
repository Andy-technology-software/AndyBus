//
//  IndexViewController.h
//  E展会
//
//  Created by 徐仁强 on 15/8/16.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpressions : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//座机号
+ (BOOL) validateMobile1:(NSString *)mobile;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
@end
