//
//  NearViewController.m
//  AndyBus
//
//  Created by lingnet on 2017/8/8.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "NearViewController.h"

#import "LLSearchViewController.h"
@interface NearViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
//定位
@property(nonatomic,strong)AMapLocationManager* locationManager;
@property(nonatomic,copy)NSString* latitu;
@property(nonatomic,copy)NSString* longit;
@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近";
    
    [self makeSearchBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [self getLocation];
}

#pragma mark - 获取当前时间点
- (NSString*)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

#pragma mark - 定位
- (void)getLocation{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [AMapServices sharedServices].apiKey = MAPKEY;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        
        NSLog(@"location:%f,%f", location.coordinate.latitude,location.coordinate.longitude);
        self.latitu = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        self.longit = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        
        NSLog(@"%@%@%@",[self getCurrentTime],self.longit,self.latitu);
        NSLog(@"%@",Query_NearbyStatInfo);
        
        [requestService Query_NearbyStatInfoWithLongitude:self.longit Latitude:self.latitu Range:@"1000" Random:@"144" SignKey:@"700ff7d35c81b94e8a18a896ed3d48b04958fed4383838d9455052345a73beca" TimeStamp:[self getCurrentTime] complate:^(id responseObject) {
            NSLog(@"请求完成---%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"请求失败");
        }];
        
        if (regeocode){
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

#pragma mark - 创建搜索按钮
- (void)makeSearchBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 33, 33);
    [rightBtn setImage:[UIImage imageNamed:@"Home_Search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

#pragma mark - 搜索按钮响应
- (void)searchAction:(UIButton *)sender{
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];
}

#pragma mark - 重写返回按钮方法
- (void)createLeftNvc{
    
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
