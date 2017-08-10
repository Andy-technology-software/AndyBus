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
    
//    [self downLoadRoads];
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


- (void)downLoadRoads{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://27.223.79.50:86/20150812140713/route.xls"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"route.xls"];
        DHxlsReader *reader = [DHxlsReader xlsReaderFromFile:[filePath absoluteString]];
        assert(reader);
#if 0
        [reader startIterator:0];
        
        while(YES) {c
            DHcell *cell = [reader nextCell];
            if(cell.type == cellBlank) break;
            
            text = [text stringByAppendingFormat:@"\n%@\n", [cell dump]];
        }
#else
        int row = 2;
        while(YES) {
            
            DHcell *cell0 = [reader cellInWorkSheetIndex:0 row:row col:1];
            if(cell0.type == cellBlank) break;
            DHcell *cell = [reader cellInWorkSheetIndex:0 row:row col:2];
            if(cell.type == cellBlank) break;
            DHcell *cell2 = [reader cellInWorkSheetIndex:0 row:row col:4];
            if(cell2.type == cellBlank) break;
            DHcell *cell3 = [reader cellInWorkSheetIndex:0 row:row col:5];
            if(cell3.type == cellBlank) break;
            DHcell *cell6 = [reader cellInWorkSheetIndex:0 row:row col:6];
            if(cell6.type == cellBlank) break;
            DHcell *cell7 = [reader cellInWorkSheetIndex:0 row:row col:7];
            if(cell7.type == cellBlank) break;
            DHcell *cell8 = [reader cellInWorkSheetIndex:0 row:row col:8];
            if(cell8.type == cellBlank) break;
            DHcell *cell9 = [reader cellInWorkSheetIndex:0 row:row col:8];
            if(cell9.type == cellBlank) break;
            DHcell *cell1 = [reader cellInWorkSheetIndex:0 row:row col:3];
            NSLog(@"\n  几路车：%@\n   查表用的号：%@\n   票价:%@\n   起点:%@\n   终点:%@\n",[cell0 dump], [cell dump], [cell1 dump], [cell2 dump], [cell3 dump]);
            row++;
        }
#endif
        
    }];
    [downloadTask resume];
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
