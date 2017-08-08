//
//  AnimatedDotView.m
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import "AnimatedDotView.h"
#define AnimateDuration 1.0

@implementation AnimatedDotView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)setDotColor:(UIColor *)dotColor{
    _dotColor = dotColor;
    self.layer.borderColor = dotColor.CGColor;
}

- (void)initialization{
    _dotColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) * 0.5;
    self.layer.borderWidth = 2.0f;
}

- (void)changeActivityState:(BOOL)active{
    if (active) {
        [self animateToActiveState];
    }else{
        [self animateToDeactiveState];
    }
}

- (void)animateToActiveState{
    
    [UIView animateWithDuration:AnimateDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = _dotColor;
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animateToDeactiveState{
    [UIView animateWithDuration:AnimateDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}






@end
