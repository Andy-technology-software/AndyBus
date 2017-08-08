//
//  requestService.h
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XRQRequestClient.h"
@interface requestService : NSObject


/**
 登录
 
 @param userId 手机号/用户账号
 @param password 密码
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUserid:(NSString*)userId password:(NSString*)password complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 上传坐标
 
 @param userId userid
 @param lat 纬度
 @param lng 经度
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postPositionUpLoadWithUserid:(NSString*)userId lat:(NSString*)lat lng:(NSString*)lng complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 获取轨迹
 
 @param userId userid
 @param date 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetTrailWithUserid:(NSString*)userId date:(NSString*)date complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 通讯录列表
 
 @param departmentId 部门id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetStaffWithDepartmentId:(NSString*)departmentId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 员工列表
 
 @param userId 自己id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSubordinateWithUserId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 签到信息
 
 @param userId 自己id
 @param time 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSigninInfoWithUserId:(NSString*)userId time:(NSString*)time complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;



/**
 签到
 
 @param userId 自己id
 @param type 考勤类型(1:wifi;2:定位;)
 @param lat 纬度
 @param lng 经度
 @param registerType 签到班次
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postSigninWithUserId:(NSString*)userId type:(NSString*)type lat:(NSString*)lat lng:(NSString*)lng registerType:(NSString*)registerType address:(NSString*)address complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;









/**
 获取首页的轮播图
 
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)getIndexBannersListsWithComplate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;


/**
 获取附近公交站站点信息
 
 @param longitude 经度
 @param latitude 纬度
 @param range 范围
 @param signKey 签名
 @param timeStamp 获取时间
 @param complate 请求完成
 @param random 不知道什么参数  随机数？
 @param failure 请求失败
 */
+(void)Query_NearbyStatInfoWithLongitude:(NSString*)longitude Latitude:(NSString*)latitude Range:(NSString*)range Random:(NSString*)random SignKey:(NSString*)signKey TimeStamp:(NSString*)timeStamp complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;

@end
