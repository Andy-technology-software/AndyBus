//
//  XRQKeyChainStore.h
//  AndyNewFram
//
//  Created by lingnet on 2017/4/19.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRQKeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
