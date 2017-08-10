//
//  LLSearchSuggestionTableViewCell.m
//  AndyBus
//
//  Created by lingnet on 2017/8/10.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "LLSearchSuggestionTableViewCell.h"

#import "BusLineDetail0Model.h"

@interface LLSearchSuggestionTableViewCell()
@property(nonatomic,strong)UIView* lineView;

@property(nonatomic,strong)UIImageView* busImageView;

@property(nonatomic,strong)UILabel* nameLable;
@property(nonatomic,strong)UILabel* priceLable;
@end
@implementation LLSearchSuggestionTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.busImageView = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"busList"];
    [self.contentView addSubview:self.busImageView];
    
    [self.busImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_offset(20);
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable.numberOfLines = 0;
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.busImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.busImageView);
    }];
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.priceLable.textColor = [UIColor orangeColor];
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(5);
    }];
    
    self.lineView = [MyController viewWithFrame:self.contentView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"dddddd"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.priceLable.mas_bottom).mas_offset(20);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(BusLineDetail0Model *)model{
    self.nameLable.text = [NSString stringWithFormat:@"%@路  %@  --  %@",model.H_NAME,model.ILLNESSES,model.DESTINATION];
    
    self.priceLable.text = model.TICKET_PRICE;
}

@end
