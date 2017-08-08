//
//  requestService.m
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "requestService.h"

@implementation requestService

/**
 登录
 
 @param userId 手机号/用户名
 @param password 密码
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUserid:(NSString*)userId password:(NSString*)password complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",LOGINURL];
    NSDictionary* param = @{@"userId":userId,@"password":password};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 上传坐标
 
 @param userId userid
 @param lat 纬度
 @param lng 经度
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postPositionUpLoadWithUserid:(NSString*)userId lat:(NSString*)lat lng:(NSString*)lng complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",positionUpload];
    NSDictionary* param = @{@"userId":userId,@"lat":lat,@"lng":lng};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 获取轨迹
 
 @param userId userid
 @param date 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetTrailWithUserid:(NSString*)userId date:(NSString*)date complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getTrail];
    NSDictionary* param = @{@"userId":userId,@"date":date};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 通讯录列表
 
 @param departmentId 部门id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetStaffWithDepartmentId:(NSString*)departmentId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getStaff];
    NSDictionary* param = @{@"departmentId":departmentId,@"userId":@""};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 员工列表
 
 @param userId 自己id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSubordinateWithUserId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getSubordinate];
    NSDictionary* param = @{@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];

}



/**
 签到信息
 
 @param userId 自己id
 @param time 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSigninInfoWithUserId:(NSString*)userId time:(NSString*)time complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getSigninInfo];
    NSDictionary* param = @{@"userId":userId,@"time":time};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



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
+(void)postSigninWithUserId:(NSString*)userId type:(NSString*)type lat:(NSString*)lat lng:(NSString*)lng registerType:(NSString*)registerType address:(NSString*)address complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",signin];
    NSDictionary* param = @{@"userId":userId,@"type":type,@"lat":lat,@"lng":lng,@"registerType":registerType,@"address":address};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}









/**
 获取首页的轮播图
 
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)getIndexBannersListsWithComplate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString *path = @"http://os.ehuizhan.com.cn/app/index!exhibitionIndex.action";
    [XRQRequestClient postWithOldURLString:path params:nil WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 获取附近公交站站点信息
 
 @param longitude 经度
 @param latitude 纬度
 @param range 范围
 @param signKey 签名
 @param timeStamp 获取时间
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)Query_NearbyStatInfoWithLongitude:(NSString*)longitude Latitude:(NSString*)latitude Range:(NSString*)range Random:(NSString*)random SignKey:(NSString*)signKey TimeStamp:(NSString*)timeStamp complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = @"http://101.200.145.66:2001/BusService/Query_NearbyStatInfo/?Longitude=120.162622&Latitude=35.963439&Range=1000&Random=149&SignKey=99ff3d72db1a1f8766b47597d1aa783bb13701beb95e61fed437e9f1270abd26&timeStamp=20170808111407";//Query_NearbyStatInfo;
//    NSDictionary* param = @{@"Longitude":longitude,@"Latitude":latitude,@"Range":range,@"Random":random,@"SignKey":signKey,@"timeStamp":timeStamp};
    
    [XRQRequestClient getWithURLString:path params:nil WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
//    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
//        !complate?:complate(responseObject);
//    } WithFailure:^(NSError *error) {
//        !failure?:failure(error);
//    }];
}



@end
