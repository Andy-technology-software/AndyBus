//
//  LLSearchSuggestionVC.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchSuggestionVC.h"

#import "LLSearchSuggestionTableViewCell.h"

#import "BusLineDetail0Model.h"

#import "BusLineDetailViewController.h"

extern int xls_debug;
@interface LLSearchSuggestionVC ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* datasourceArr;

@end

@implementation LLSearchSuggestionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self createTableView];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
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
    [HUD loading];
    BusLineDetailViewController* vc = [[BusLineDetailViewController alloc] init];
    BusLineDetail0Model* model = self.datasourceArr[indexPath.row];
    vc.model0 = model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"BusLineDetailTableViewCell";
    LLSearchSuggestionTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[LLSearchSuggestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //    cell0.IndexViewCellDelegate = self;
    BusLineDetail0Model* model = self.datasourceArr[indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusLineDetail0Model* model = self.datasourceArr[indexPath.row];

    return [LLSearchSuggestionTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        LLSearchSuggestionTableViewCell *cell = (LLSearchSuggestionTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)searchTestChangeWithTest:(NSString *)test{
    //青岛0   胶南8  平度4   莱西2  即墨3    胶州5
    [self.datasourceArr removeAllObjects];
    for (int i = 0; i < 65; i++) {
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"route(%d).xls",i]];
        NSLog(@"--%@",path);
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
            DHcell *cell9 = [reader cellInWorkSheetIndex:0 row:row col:9];
            if(cell9.type == cellBlank) break;
            DHcell *cell1 = [reader cellInWorkSheetIndex:0 row:row col:3];
            NSLog(@"\n  几路车：%@\n   查表用的号：%@\n   票价:%@\n   起点:%@\n   终点:%@\n",[cell0 dump], [cell dump], [cell1 dump], [cell2 dump], [cell3 dump]);
            row++;
            
            //text = [text stringByAppendingFormat:@"\n%@\n", [cell dump]];
            //text = [text stringByAppendingFormat:@"\n%@\n", [cell1 dump]];
            if ([[cell0 dump] rangeOfString:test].location != NSNotFound && 8 == [[cell8 dump] intValue]) {
                BusLineDetail0Model* model = [[BusLineDetail0Model alloc] init];
                model.H_NAME = [cell0 dump];
                model.H_LINE = [cell dump];
                model.TICKET_PRICE = [cell1 dump];
                model.ILLNESSES = [cell2 dump];
                model.DESTINATION = [cell3 dump];
                model.DOWN_TIME = [cell6 dump];
                model.UP_TIME = [cell7 dump];
                model.H_CPY = [cell8 dump];
                model.CMD = [cell9 dump];
                [self.datasourceArr addObject:model];
            }
            
            [_tableView reloadData];
        }
        
#endif
    }
    
    
//    _searchTest = test;
    [_tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
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
