//
//  XRQRequestClient.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/3.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSURLErrorFailingURLStringErrorKey @"NSURLErrorFailingURLStringErrorKey" // error userInfo 错误信息key

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(NSError *error);
@interface XRQRequestClient : NSObject
+(void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;
+(void)getWithURLString:(NSString *)urlString params:(NSDictionary *)params WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;
+(void)postWithOldURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;

@end
