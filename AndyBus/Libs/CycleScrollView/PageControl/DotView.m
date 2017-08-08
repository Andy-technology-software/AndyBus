//
//  DotView.m
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import "DotView.h"

@implementation DotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)initialization{
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) * 0.5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2.0f;
}

- (void)changeActivityState:(BOOL)active{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
