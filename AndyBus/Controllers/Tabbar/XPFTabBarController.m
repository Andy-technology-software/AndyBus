//
//  XPFTabBarController.m
//  tabBarDome
//
//  Created by www.xpf.com on 2017/7/24.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//

#import "XPFTabBarController.h"

#import "XPFNavigationController.h"

#import "XPFTabBar.h"

#import "IndexViewController.h"

#import "NearViewController.h"
@interface XPFTabBarController () <XPFTabBarDelegate> {
    UIView *adView;
}

@end

@implementation XPFTabBarController

+ (void)initialize {
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"BG_image"]];  //tabbar-light
    
}

- (void)viewDidLoad {
    
    // 替换tabbar
    XPFTabBar *tabBar = [[XPFTabBar alloc] init];
    tabBar.adDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    // 添加
    [self setupChildViewControllers];
    
}

- (void)setupChildViewControllers {
    [self addAppearance];
    
    //
    [self setUpOneChildViewController:[[IndexViewController alloc] init] title:@"首页" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    //
    [self setUpOneChildViewController:[[NearViewController alloc] init] title:@"附近" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    //
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"中心" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
    //
    [self setUpOneChildViewController:[[UIViewController alloc] init] title:@"时间" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    
    
}

#pragma mark - <添加一个子控制器>
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    //vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    [self addChildViewController:[[XPFNavigationController alloc] initWithRootViewController:vc]];
}

#pragma mark - <appearance>
- (void)addAppearance {
    [UINavigationBar appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    // 未选中的颜色
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1.0];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    // 点击后的颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


#pragma mark - ADTabBarDelegate
- (void)tabBarDidClickCenterButton:(XPFTabBar *)tabBar {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    adView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
    adView.backgroundColor = [UIColor clearColor];
    adView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.3];
    [window addSubview:adView];
    [self creatBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [adView addGestureRecognizer:tap];
    
}
// 手势点击事件
- (void)touch {
    [self remove_adVeiw];
}

/** 删除 view */
- (void)remove_adVeiw {
    [adView removeFromSuperview];
}

- (void)ItemBtnClick:(UIButton *)btn {
    [self remove_adVeiw];
    // 添加动画  好看
    // 本次选择删除 view ，没有选 隐藏
    switch (btn.tag) {
        case 10001: {
//            UIViewController *d = [[UIViewController alloc] init];
//            [self presentViewController:d animated:YES completion:nil];
        } break;
        case 10002: {
            
        } break;
        case 10003: {
            
        } break;
            
        default:
            break;
    }
}


/** 创建 btn*/
- (void)creatBtn {
    // 按钮1
    CGFloat oneBtnw = 60;
    CGFloat oneBtnh = oneBtnw;
    CGFloat oneBtnx = adView.xpf_width/5;
    CGFloat oneBtny = adView.xpf_height - 49 - oneBtnw*2;
    UIButton *oneBtn = [[UIButton alloc] initWithFrame:CGRectMake(oneBtnx, oneBtny, oneBtnw, oneBtnh)];
    [oneBtn setImage:[UIImage imageNamed:@"icon_popup_gift"] forState:(UIControlStateNormal)];
    oneBtn.clipsToBounds = YES;
    oneBtn.layer.cornerRadius = oneBtnw/2;
    oneBtn.tag = 10001;
    [oneBtn addTarget:self action:@selector(ItemBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [adView addSubview:oneBtn];
    // 按钮2
    CGFloat twoBtnw = oneBtnw;
    CGFloat twoBtnh = twoBtnw;
    CGFloat twoBtnx = adView.xpf_width/2 - twoBtnw/2;
    CGFloat twoBtny = oneBtny - twoBtnh;
    UIButton *twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(twoBtnx, twoBtny, twoBtnw, twoBtnh)];
    [twoBtn setImage:[UIImage imageNamed:@"icon_popup_money"] forState:(UIControlStateNormal)];
    twoBtn.clipsToBounds = YES;
    twoBtn.layer.cornerRadius = oneBtnw/2;
    twoBtn.tag = 10002;
    [twoBtn addTarget:self action:@selector(ItemBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [adView addSubview:twoBtn];
    
    // 按钮3
    CGFloat threeBtnw = oneBtnw;
    CGFloat threeBtnh = threeBtnw;
    CGFloat threeBtnx = twoBtnx + (twoBtnx - oneBtnx);
    CGFloat threeBtny = oneBtny;
    UIButton *threeBtn = [[UIButton alloc] initWithFrame:CGRectMake(threeBtnx, threeBtny, threeBtnw, threeBtnh)];
    [threeBtn setImage:[UIImage imageNamed:@"icon_popup_kefu"] forState:(UIControlStateNormal)];
    threeBtn.clipsToBounds = YES;
    threeBtn.layer.cornerRadius = oneBtnw/2;
    threeBtn.tag = 10003;
    [threeBtn addTarget:self action:@selector(ItemBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [adView addSubview:threeBtn];
    
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
