//
//  XRQRequestClient.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/3.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "XRQRequestClient.h"

@implementation XRQRequestClient
+(void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求结果:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"statusCode"] isEqualToString:@"200"]) {
                !success?:success(responseObject);
            }else{
                NSString *errorDomainValue = @"RequestError";
                NSError *error = [NSError errorWithDomain:errorDomainValue code:[responseObject[@"statusCode"]intValue] userInfo:@{NSURLErrorFailingURLStringErrorKey:[MyController returnStr:responseObject[@"msg"]]}];
                !failure?:failure(error);
            }
            
        }
        else{
            NSString *errorDomainValue = @"RequestError";
            NSError *error = [NSError errorWithDomain:errorDomainValue code:-999 userInfo:@{NSURLErrorFailingURLStringErrorKey:@"返回的数据不是json"}];
            !failure?:failure(error);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        !failure?:failure(error);
    }];
}

+(void)postWithOldURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    [HUD loading];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求结果:%@",responseObject);
        if ([responseObject[@"result"] intValue]) {
            [HUD hide];
            !success?:success(responseObject);
        }else{
            NSString *errStr = [responseObject objectForKey:@"error"];
            NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
            [HUD error:[dic objectForKey:@"errorInfo"]];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [HUD warning:@"请检查网络连接"];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        !failure?:failure(error);
    }];
}

+(void)getWithURLString:(NSString *)urlString params:(NSDictionary *)params WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    mgr.requestSerializer.timeoutInterval = 30;
    
    [mgr GET:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求结果:%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"statusCode"] isEqualToString:@"200"]) {
                !success?:success(responseObject);
            }else{
                NSString *errorDomainValue = @"RequestError";
                NSError *error = [NSError errorWithDomain:errorDomainValue code:[responseObject[@"statusCode"]intValue] userInfo:@{NSURLErrorFailingURLStringErrorKey:[MyController returnStr:responseObject[@"msg"]]}];
                !failure?:failure(error);
            }
            
        }
        else{
            NSString *errorDomainValue = @"RequestError";
            NSError *error = [NSError errorWithDomain:errorDomainValue code:-999 userInfo:@{NSURLErrorFailingURLStringErrorKey:@"返回的数据不是json"}];
            !failure?:failure(error);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        !failure?:failure(error);
    }];
    
}

@end
