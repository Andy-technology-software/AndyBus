//
//  BusLineDetailViewController.m
//  AndyBus
//
//  Created by lingnet on 2017/8/9.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "BusLineDetailViewController.h"

#import "BusLineDetail1Model.h"
@interface BusLineDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@property(nonatomic,strong)NSMutableArray* datasourceArr;
@end

@implementation BusLineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.title = [NSString stringWithFormat:@"%@路",self.model0.H_NAME];
    
    [self createTableView];
    
    [self getLineDetail];
}

#pragma mark - 获取对应站点
- (void)getLineDetail{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"linesite.xls"];
    DHxlsReader *reader = [DHxlsReader xlsReaderFromFile:path];
    assert(reader);
#if 0
    [reader startIterator:0];
    
    while(YES) {
        DHcell *cell = [reader nextCell];
        if(cell.type == cellBlank) break;
        
        text = [text stringByAppendingFormat:@"\n%@\n", [cell dump]];
    }
#else
    int row = 2;
    while(YES) {
        
        DHcell *cell1 = [reader cellInWorkSheetIndex:0 row:row col:1];
        if(cell1.type == cellBlank) break;
        DHcell *cell2 = [reader cellInWorkSheetIndex:0 row:row col:2];
        if(cell2.type == cellBlank) break;
        DHcell *cell3 = [reader cellInWorkSheetIndex:0 row:row col:3];
        if(cell3.type == cellBlank) break;
        DHcell *cell4 = [reader cellInWorkSheetIndex:0 row:row col:4];
//        NSLog(@"\n  H_LINE：%@\n   T_NAME：%@\n   STATION_ID:%@\n   DIRECTION:%@\n",[cell1 dump], [cell2 dump], [cell3 dump], [cell4 dump]);
        row++;
        
        if ([self.model0.H_LINE isEqualToString:[cell1 dump]]) {
            BusLineDetail1Model* model1 = [[BusLineDetail1Model alloc] init];
            model1.H_LINE = [cell1 dump];
            model1.T_NAME = [cell2 dump];
            model1.STATION_ID = [cell3 dump];
            model1.DIRECTION = [cell4 dump];
            [self.datasourceArr addObject:model1];
            
            
            NSLog(@"%@    ",model1.T_NAME);
        }
    
    }
#endif
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
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
    return self.datasourceArr.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    return cell;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}

#pragma mark - 创建头标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 80)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel* titleLable = [MyController createLabelWithFrame:headView.frame Font:16 Text:[NSString stringWithFormat:@"%@ -> %@",self.model0.ILLNESSES,self.model0.DESTINATION]];
    [headView addSubview:titleLable];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(10);
    }];
    
    UILabel* timeLable = [MyController createLabelWithFrame:headView.frame Font:14 Text:[NSString stringWithFormat:@"运营时间：%@  %@",self.model0.DOWN_TIME,self.model0.TICKET_PRICE]];
    timeLable.textColor = [UIColor lightGrayColor];
    [headView addSubview:timeLable];
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLable);
        make.right.mas_equalTo(titleLable);
        make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(5);
    }];
    
    UIButton* changeBtn = [MyController createButtonWithFrame:headView.frame ImageName:@"shijian" Target:self Action:@selector(changeBtn) Title:@"换向"];
    [changeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [headView addSubview:changeBtn];
    
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(60);
        make.centerY.mas_equalTo(headView);
    }];
    
    return headView;
}

#pragma mark - 换向按钮响应
- (void)changeBtn{
    NSLog(@"换向");
}
#pragma mark - 头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
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
