//
//  XPFTabBar.h
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@class XPFTabBar;

//因为XPFTabBar继承自UITabBar
//所以成为XPFTabBar的代理，也必须实现UITabBar的代理协议
@protocol XPFTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickCenterButton:(XPFTabBar *)tabBar;

@end

@interface XPFTabBar : UITabBar

@property (nonatomic, weak) id<XPFTabBarDelegate> adDelegate;

@end
