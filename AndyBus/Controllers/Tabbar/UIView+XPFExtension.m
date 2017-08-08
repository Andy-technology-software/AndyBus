//
//  UIView+XPFExtension.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//


#import "UIView+XPFExtension.h"

@implementation UIView (XPFExtension)
- (void)setXpf_x:(CGFloat)xpf_x
{
    CGRect frame = self.frame;
    frame.origin.x = xpf_x;
    self.frame = frame;
}

- (void)setXpf_y:(CGFloat)xpf_y
{
    CGRect frame = self.frame;
    frame.origin.y = xpf_y;
    self.frame = frame;
}

- (void)setXpf_width:(CGFloat)xpf_width
{
    CGRect frame = self.frame;
    frame.size.width = xpf_width;
    self.frame = frame;
}

- (void)setXpf_height:(CGFloat)xpf_height
{
    CGRect frame = self.frame;
    frame.size.height = xpf_height;
    self.frame = frame;
}

- (CGFloat)xpf_x
{
    return self.frame.origin.x;
}

- (CGFloat)xpf_y
{
    return self.frame.origin.y;
}

- (CGFloat)xpf_width
{
    return self.frame.size.width;
}

- (CGFloat)xpf_height
{
    return self.frame.size.height;
}

- (void)setXpf_centerX:(CGFloat)xpf_centerX
{
    CGPoint center = self.center;
    center.x = xpf_centerX;
    self.center = center;
}

- (void)setXpf_centerY:(CGFloat)xpf_centerY
{
    CGPoint center = self.center;
    center.y = xpf_centerY;
    self.center = center;
}

- (CGFloat)xpf_centerX
{
    return self.center.x;
}

- (CGFloat)xpf_centerY
{
    return self.center.y;
}
@end
