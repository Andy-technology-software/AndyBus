//
//  BusLineDetailViewController.m
//  AndyBus
//
//  Created by lingnet on 2017/8/9.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "BusLineDetailViewController.h"

#import "BusLineDetail1Model.h"

#import "BusLineDetailTableViewCell.h"
@interface BusLineDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,assign)BOOL isDown;
@property(nonatomic,strong)NSMutableArray* datasourceArr;
@property(nonatomic,strong)NSMutableArray* datasourceArr1;

@end

@implementation BusLineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
    self.title = [NSString stringWithFormat:@"%@路",self.model0.H_NAME];
    
    [self createTableView];
    
    [HUD loading];
    [self getLineDetail];
}

#pragma mark - 获取对应站点
- (void)getLineDetail{
    for (int i = 0; i < 108; i++) {
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"linesite(%d).xls",i]];
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
        int i = 1;
        int k = 1;
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
                //            model1.DIRECTION = [cell4 dump];
                if ([[cell4 dump] intValue]) {
                    model1.STATION_ID = [NSString stringWithFormat:@"%d",i++];
                    if (2 == i) {
                        model1.isReceived = YES;
                    }
                    [self.datasourceArr addObject:model1];
                }else{
                    model1.STATION_ID = [NSString stringWithFormat:@"%d",k++];
                    if (6 == k) {
                        model1.isReceived = YES;
                    }
                    [self.datasourceArr1 addObject:model1];
                }
                NSLog(@"%@    ",model1.T_NAME);
            }
            
        }
        [HUD success:@"查询成功"];
        [_tableView reloadData];
#endif
    }
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
    if (self.isDown) {
        return self.datasourceArr1.count;
    }
    return self.datasourceArr.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"BusLineDetailTableViewCell";
    BusLineDetailTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[BusLineDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell0.IndexViewCellDelegate = self;
    BusLineDetail1Model* model;
    if (self.isDown) {
        model = self.datasourceArr1[indexPath.row];
    }else{
        model = self.datasourceArr[indexPath.row];
    }
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusLineDetail1Model* model;
    if (self.isDown) {
        model = self.datasourceArr1[indexPath.row];
    }else{
        model = self.datasourceArr[indexPath.row];
    }
    return [BusLineDetailTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        BusLineDetailTableViewCell *cell = (BusLineDetailTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - 创建头标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 80)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIButton* changeBtn = [MyController createButtonWithFrame:headView.frame ImageName:@"arrow_change1" Target:self Action:@selector(changeBtn:) Title:nil];
    [headView addSubview:changeBtn];
    
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6);
        make.width.mas_offset(30);
        make.height.mas_offset(32);
        make.centerY.mas_equalTo(headView);
    }];
    
    UIButton* changeBtn1 = [MyController createButtonWithFrame:headView.frame ImageName:nil Target:self Action:@selector(changeBtn:) Title:@"换向"];
    [changeBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeBtn1.titleLabel.font = [UIFont systemFontOfSize:10];
    [headView addSubview:changeBtn1];
    
    [changeBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(changeBtn);
        make.width.mas_equalTo(changeBtn);
        make.height.mas_offset(20);
        make.top.mas_equalTo(changeBtn.mas_bottom);
    }];
    
    
    UILabel* priceLable = [MyController createLabelWithFrame:headView.frame Font:14 Text:[NSString stringWithFormat:@"%@",self.model0.TICKET_PRICE]];
    priceLable.textColor = [UIColor orangeColor];
    priceLable.textAlignment = NSTextAlignmentRight;
    [headView addSubview:priceLable];
    
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(changeBtn.mas_left).mas_offset(-6);
        make.top.mas_equalTo(10);
    }];
    
    UILabel* titleLable = [MyController createLabelWithFrame:headView.frame Font:16 Text:nil];
    [headView addSubview:titleLable];
    
    if (self.isDown) {
        titleLable.text = [NSString stringWithFormat:@"%@ -> %@",self.model0.DESTINATION,self.model0.ILLNESSES];
    }else{
        titleLable.text = [NSString stringWithFormat:@"%@ -> %@",self.model0.ILLNESSES,self.model0.DESTINATION];
    }
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(priceLable);
        make.right.mas_equalTo(priceLable.mas_left);
    }];
    
    UILabel* timeLable = [MyController createLabelWithFrame:headView.frame Font:14 Text:nil];
    timeLable.textColor = [UIColor lightGrayColor];
    timeLable.numberOfLines = 0;
    [headView addSubview:timeLable];
    
    if (self.isDown) {
        timeLable.text = [NSString stringWithFormat:@"运营时间：%@",self.model0.UP_TIME];
    }else{
        timeLable.text = [NSString stringWithFormat:@"运营时间：%@",self.model0.DOWN_TIME];
    }
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLable);
        make.right.mas_equalTo(priceLable);
        make.top.mas_equalTo(titleLable.mas_bottom).mas_offset(6);
    }];
    
    return headView;
}

#pragma mark - 换向按钮响应
- (void)changeBtn:(UIButton*)btn{
    self.isDown = !self.isDown;
    [_tableView reloadData];
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
