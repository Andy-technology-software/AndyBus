//
//  IndexViewTableViewCell.h
//  AndyNewFram
//
//  Created by lingnet on 2017/4/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexModel;
@protocol IndexViewCellDelegate <NSObject>
- (void)didselectADPic:(NSInteger)index;
@end
@interface IndexViewTableViewCell : UITableViewCell
@property(nonatomic,weak)id<IndexViewCellDelegate>IndexViewCellDelegate;
@property(nonatomic,strong) NSMutableArray* picArr;
- (void)configCellWithModel:(IndexModel *)model;
@end
