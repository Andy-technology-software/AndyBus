//
//  Index1TableViewCell.h
//  AndyBus
//
//  Created by lingnet on 2017/8/7.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Index1Model;
@protocol Index1TableViewCellDelegate <NSObject>
- (void)didselectItem:(NSInteger)index;
@end
@interface Index1TableViewCell : UITableViewCell

@property(nonatomic,weak)id<Index1TableViewCellDelegate>Index1TableViewCellDelegate;
- (void)configCellWithModel:(Index1Model *)model;

@end
