//
//  XRQGetOnlyUUID.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/19.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "XRQGetOnlyUUID.h"

#import "XRQKeyChainStore.h"

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"

@implementation XRQGetOnlyUUID

+ (NSString *)getUUID {
    
    NSString * strUUID = (NSString *)[XRQKeyChainStore load:@"com.company.app.usernamepassword"];
    
    // 首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [XRQKeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

@end
