//
//  CycleScrollView.h
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CycleScrollViewPageContolAlimentRight,
    CycleScrollViewPageContolAlimentCenter
} CycleScrollViewPageContolAliment;

typedef enum {
    CycleScrollViewPageContolStyleClassic,        // 系统自带经典样式
    CycleScrollViewPageContolStyleAnimated,       // 动画效果pagecontrol
    CycleScrollViewPageContolStyleNone            // 不显示pagecontrol
} CycleScrollViewPageContolStyle;


@class CycleScrollView;

@protocol CycleScrollViewDelegate <NSObject>


@optional
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

- (void)indexOnPageControl:(NSInteger)index;

@end



@interface CycleScrollView : UIView

// >>>>>>>>>>>>>>>>>>>>>>>>>>  数据源接口

// 本地图片数组
@property (nonatomic, strong) NSArray *localizationImagesGroup;

// 网络图片 url string 数组
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

// 每张图片对应要显示的文字数组
@property (nonatomic, strong) NSArray *titlesGroup;

@property (nonatomic, assign) int indexPage;



// >>>>>>>>>>>>>>>>>>>>>>>>>  滚动控制接口

// 自动滚动间隔时间,默认2s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

// 是否无限循环,默认Yes
@property(nonatomic,assign) BOOL infiniteLoop;

// 是否自动滚动,默认Yes
@property(nonatomic,assign) BOOL autoScroll;

@property (nonatomic, weak) id<CycleScrollViewDelegate> delegate;




// >>>>>>>>>>>>>>>>>>>>>>>>>  自定义样式接口

// 是否显示分页控件
@property (nonatomic, assign) BOOL showPageControl;

// pagecontrol 样式，默认为动画样式
@property (nonatomic, assign) CycleScrollViewPageContolStyle pageControlStyle;

// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;

// 分页控件位置
@property (nonatomic, assign) CycleScrollViewPageContolAliment pageControlAliment;

// 分页控件小圆标大小
@property (nonatomic, assign) CGSize pageControlDotSize;

// 分页控件小圆标颜色
@property (nonatomic, strong) UIColor *dotColor;

//分页控件当前小圆标颜色
@property (nonatomic,strong) UIColor *indicatorDotColor;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;


+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;

@end
