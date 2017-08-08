//
//  PageControl.h
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageControl;
@protocol PageControlDelegate <NSObject>

@optional
- (void)PageControl:(PageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end

@interface PageControl : UIControl

/**
 *  点视图属性
 */

/**
*  自定义的类必须要遵循AbstractDotView类
*/
@property (nonatomic) Class dotViewClass;

//@property (nonatomic,strong) UIColor *red;

@property (nonatomic,strong) UIImage  *dotImage;

@property (nonatomic,assign) CGSize dotSize;

@property (nonatomic,strong) UIColor *dotColor;

@property (nonatomic,assign) NSInteger spacingBetweenDots;


/**
 *  Page control属性
 */

@property (nonatomic,assign) NSInteger numberOfPages;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) BOOL hidesForSinglePage;

@property (nonatomic,assign) BOOL shouldResizeFromCenter;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@property (nonatomic,weak) id<PageControlDelegate> delegate;

@end
