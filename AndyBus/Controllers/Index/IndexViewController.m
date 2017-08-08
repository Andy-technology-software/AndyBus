//
//  IndexViewController.m
//  AndyBus
//
//  Created by lingnet on 2017/8/7.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "IndexViewController.h"

#import "IndexModel.h"

#import "IndexViewTableViewCell.h"

#import "Index1Model.h"

#import "Index1TableViewCell.h"

#import "LLSearchViewController.h"
@interface IndexViewController ()<UITableViewDataSource,UITableViewDelegate,IndexViewCellDelegate,MWPhotoBrowserDelegate,Index1TableViewCellDelegate>{
    UITableView* _tableView;
}
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;

@property(nonatomic,retain)NSMutableArray* picturesArr;
@property(nonatomic,retain)NSMutableArray* picturesArr1;

@property(nonatomic,retain)NSMutableArray* dataSource1;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    self.picturesArr = [[NSMutableArray alloc] init];
    self.picturesArr1 = [[NSMutableArray alloc] init];
    self.photos = [[NSMutableArray alloc] init];
    self.dataSource1 = [[NSMutableArray alloc] init];
    Index1Model* model1 = [[Index1Model alloc] init];
    [self.dataSource1 addObject:model1];
    
    [self createTableView];
    [self getIndexBannder];
}

- (void)createLeftNvc{
    
}

#pragma mark - 获取广告图
- (void)getIndexBannder {
    [requestService getIndexBannersListsWithComplate:^(id responseObject) {
        NSDictionary* sourceDic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
        self.picturesArr = [IndexModel mj_objectArrayWithKeyValuesArray:sourceDic[@"ad"]];
        for (IndexModel* M in self.picturesArr) {
            NSLog(@"----%@",M.img);
            [self.picturesArr1 addObject:M.img];
            [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", M.img]]]];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [HUD warning:@"请求出错"];
    }];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - 49 - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        static NSString *cellIdentifier = @"CellIdentifier";
        IndexViewTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell0) {
            cell0 = [[IndexViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell0.IndexViewCellDelegate = self;
        cell0.picArr = [[NSMutableArray alloc] initWithArray:self.picturesArr1];
        IndexModel* model = nil;
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }
    
    
//    static NSString *cellIdentifier = @"Index1TableViewCell";
//    Index1TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell0) {
//        cell0 = [[Index1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    Index1TableViewCell* cell0 = [[Index1TableViewCell alloc] init];
    cell0.Index1TableViewCellDelegate = self;
    Index1Model* model = nil;
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return [MyController getScreenWidth] * 43/72;
    }
    
    Index1Model* model = self.dataSource1[indexPath.row];
    return [Index1TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        Index1TableViewCell *cell = (Index1TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - 查看图片代理
- (void)didselectADPic:(NSInteger)index{
    [_photoBrowser setCurrentPhotoIndex:index];
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}

#pragma mark - 点击item代理
- (void)didselectItem:(NSInteger)index{
    NSLog(@"点击了item----%ld",index);
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];
}

#pragma mark - getter 创建一个显示图片的window
- (UIWindow *)keyWindow{
    if(_keyWindow == nil){
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return _keyWindow;
}
#pragma mark - 初始化MWPhotoBrowser
- (MWPhotoBrowser *)photoBrowser{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
    }
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count){
        return [self.photos objectAtIndex:index];
    }
    return nil;
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
