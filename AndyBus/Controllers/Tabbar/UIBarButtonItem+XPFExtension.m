//
//  UIBarButtonItem+XPFExtension.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//

#import "UIBarButtonItem+XPFExtension.h"

@implementation UIBarButtonItem (XPFExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero, [btn backgroundImageForState:UIControlStateNormal].size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
