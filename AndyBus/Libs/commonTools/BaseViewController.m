//
//  BaseViewController.m
//  AndyCoder
//
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [MyController colorWithHexString:@"FFA042"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    
    [self createLeftNvc];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)createLeftNvc{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,27,27)];
    [rightButton setImage:[UIImage imageNamed:@"fh"]forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"fh"]forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
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
