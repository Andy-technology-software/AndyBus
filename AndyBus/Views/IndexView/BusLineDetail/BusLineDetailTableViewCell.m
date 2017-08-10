//
//  BusLineDetailTableViewCell.m
//  AndyBus
//
//  Created by lingnet on 2017/8/9.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "BusLineDetailTableViewCell.h"

#import "BusLineDetail1Model.h"

@interface BusLineDetailTableViewCell()
@property(nonatomic,strong)UIView* shuLineView;

@property(nonatomic,strong)UIImageView* busImageView;

@property(nonatomic,strong)UILabel* dianLable;
@property(nonatomic,strong)UILabel* nameLable;
@end
@implementation BusLineDetailTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:@"efeff8"];
    
    self.shuLineView = [MyController viewWithFrame:self.contentView.frame];
    self.shuLineView.backgroundColor = [MyController colorWithHexString:@"4fb672"];
    [self.contentView addSubview:self.shuLineView];
    
    [self.shuLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(0);
        make.width.mas_offset(8);
    }];
    
    self.dianLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.dianLable.backgroundColor = [UIColor orangeColor];
    self.dianLable.textColor = [UIColor whiteColor];
    self.dianLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dianLable];
    
    //将图层的边框设置为圆脚
    self.dianLable.layer.cornerRadius = 10;
    self.dianLable.layer.masksToBounds = YES;
    [self.dianLable setContentMode:UIViewContentModeScaleAspectFill];
    self.dianLable.clipsToBounds = YES;
    
    [self.dianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shuLineView);
        make.centerY.mas_equalTo(self.shuLineView);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dianLable.mas_right).mas_offset(6);
//        make.centerY.mas_equalTo(self.numLable);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(20);
    }];
    
    
    [self.shuLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.nameLable.mas_bottom).mas_offset(20);
    }];
    
    self.busImageView = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.busImageView];
    
    [self.busImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
    
    self.hyb_lastViewInCell = self.shuLineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(BusLineDetail1Model *)model{
    self.nameLable.text = model.T_NAME;
    self.dianLable.text = [NSString stringWithFormat:@"%d",[model.STATION_ID intValue]];
    if (model.isReceived) {
        self.busImageView.image = [UIImage imageNamed:@"bus"];
    }else{
        self.busImageView.image = [UIImage imageNamed:@""];
    }
}
@end
