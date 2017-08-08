//
//  XPFTabBar.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//


#import "XPFTabBar.h"

#import "Masonry.h"
#import "UIView+XPFExtension.h"

@implementation XPFTabBar

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tab-zuo-icon-normal"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tab-zuo-icon-normal"] forState:UIControlStateHighlighted];
        //tab-zuo-icon-normal
        //tabBar_publish_click_icon
        [self addSubview:publishButton];
        [publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(publishButton).insets(UIEdgeInsetsMake(-20, 0, 20, 0));
            make.center.mas_equalTo(self);
            make.size.mas_equalTo([publishButton backgroundImageForState:(UIControlStateNormal)].size);
            
        }];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)publishClick {
    NSLog(@" 放学别走  接下来要执行 delete 了 ");
    [self.adDelegate tabBarDidClickCenterButton:self];
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 原来的4个
    CGFloat width = self.xpf_width / 5;
    int index = 0;
    for (UIControl *control in self.subviews) {
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
        control.xpf_width = width;
        control.xpf_x = index > 1 ? width * (index + 1) : width * index;
        index++;
    }
}

@end
