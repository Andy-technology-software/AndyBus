//
//  AbstractDotView.m
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import "AbstractDotView.h"

@implementation AbstractDotView

- (instancetype)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}

- (void)changeActivityState:(BOOL)active{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}

@end
