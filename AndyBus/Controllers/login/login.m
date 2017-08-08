//
//  login.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//

#import "login.h"

#import "XPFTabBarController.h"
@interface login ()

@end

@implementation login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 100, 100)];
    [btn setTitle:@"login..." forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}

- (void)btnClick { NSLog(@"  login........  ");
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[XPFTabBarController alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
