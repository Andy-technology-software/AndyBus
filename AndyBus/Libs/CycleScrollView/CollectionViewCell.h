//
//  CollectionViewCell.h
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) UIColor *titleLabelTextColor;
@property (nonatomic,strong) UIFont *titleLabelTextFont;
@property (nonatomic,strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic,assign) CGFloat titleLabelHeight;

@property (nonatomic,assign) BOOL hasConfigued;

@end
