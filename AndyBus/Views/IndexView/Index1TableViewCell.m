//
//  Index1TableViewCell.m
//  AndyBus
//
//  Created by lingnet on 2017/8/7.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "Index1TableViewCell.h"

#import "Index1Model.h"

@interface Index1TableViewCell()
@property(nonatomic,strong)UIView* bgView;

@end
@implementation Index1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(Index1Model *)model{
    float viewWidth = [MyController getScreenWidth] / 4;
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(3 * viewWidth);
    }];
    
    NSArray* imageNameA = [NSArray arrayWithObjects:@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian",@"shijian", nil];
    NSArray* titleA = [NSArray arrayWithObjects:@"线路查询",@"站点查询",@"车辆查询",@"导程",@"周边",@"资讯消息",@"我都收藏",@"失物招领",@"意见反馈",@"设置",@"扫一扫", nil];
    for (int i = 0; i < 11; i++) {
        UIImageView* _imageV = [MyController createImageViewWithFrame:CGRectMake(viewWidth * (i % 4) + (viewWidth - 50) / 2, 5 + (i / 4) * viewWidth, 50, 50) ImageName:imageNameA[i]];
        [self.bgView addSubview:_imageV];
        
        UILabel* titleLable = [MyController createLabelWithFrame:CGRectMake(viewWidth * (i % 4), CGRectGetMaxY(_imageV.frame), viewWidth, 20) Font:12 Text:titleA[i]];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:titleLable];
        
        UIButton* seleBtn = [MyController createButtonWithFrame:CGRectMake(viewWidth * (i % 4), viewWidth * (i / 4), viewWidth, viewWidth) ImageName:nil Target:self Action:@selector(seleBtnClick:) Title:nil];
        seleBtn.tag = 100 + i;
        [self.bgView addSubview:seleBtn];
    }
}


- (void)seleBtnClick:(UIButton*)btn{
    [self.Index1TableViewCellDelegate didselectItem:btn.tag - 100];
}
@end
