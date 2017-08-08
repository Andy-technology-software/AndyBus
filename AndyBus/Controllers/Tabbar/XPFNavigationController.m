//
//  XPFNavigationController.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//


#import "XPFNavigationController.h"

@interface XPFNavigationController ()

@end

@implementation XPFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    // 需求要求导航时图片
    //UIImage *bg = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
    //[bar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
    // 设置导航文字颜色和大小
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"<" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = CGRectMake(0, 0, 30, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
