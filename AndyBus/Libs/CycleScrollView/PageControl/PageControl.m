//
//  PageControl.m
//  轮播图
//
//  Created by MyMac on 15/9/15.
//  Copyright (c) 2015年 MyMac. All rights reserved.
//

#import "PageControl.h"
#import "AbstractDotView.h"
#import "AnimatedDotView.h"
#import "DotView.h"


/**
 *  默认页数
 */
static NSInteger const kDefaultNumberOfPages = 0;

/**
 *  当前页
 */
static NSInteger const kDefaultCurrentPage = 0;

/**
 *  只有一页时隐藏pagecontrol
 */
static BOOL const kDefaultHideForSinglePage = NO;

/**
 *  Default setting for shouldResizeFromCenter. For initialiation
 */
static BOOL const kDefaultShouldResizeFromCenter = YES;

/**
 *  每个点之间的距离
 */
static NSInteger const kDefaultSpacingBetweenDots = 8;

/**
 *  点的大小
 */
static CGSize const kDefaultDotSize = {8, 8};


@interface PageControl ()

@property (nonatomic,strong) NSMutableArray *dots;

@end

@implementation PageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

/**
 *  默认设置
 */
- (void)initialization{
    self.dotViewClass = [AnimatedDotView class];
    self.spacingBetweenDots = kDefaultSpacingBetweenDots;
    self.numberOfPages = kDefaultNumberOfPages;
    self.currentPage = kDefaultCurrentPage;
    self.hidesForSinglePage = kDefaultHideForSinglePage;
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view != self) {
        NSInteger index = [self.dots indexOfObject:touch.view];
        if ([self.delegate respondsToSelector:@selector(PageControl:didSelectPageAtIndex:)]) {
            [self.delegate PageControl:self didSelectPageAtIndex:index];
        }
    }
}

#pragma mark - Layout
- (void)sizeToFit{
    [self updateFrame:YES];
}

/**
 *  计算PageControl的高度和宽度
 */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount{
    return CGSizeMake((self.dotSize.width + self.spacingBetweenDots) * pageCount - self.spacingBetweenDots, self.dotSize.height);
}

/**
 *  更新点
 */
- (void)updateDots{
    if (self.numberOfPages == 0) return;
    
    for (NSInteger i = 0; i < self.numberOfPages; i ++) {
        UIView *dot;
        if (i < self.dots.count) {
            dot = [self.dots objectAtIndex:i];
        }else{
            dot = [self generateDotView];
        }
        [self updateDotFrame:dot atIndex:i];
        
    }
    [self changeActivity:YES atIndex:self.currentPage];
    [self hideForSinglePage];
    
}


- (void)updateFrame:(BOOL)overrideExistingFrame
{
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];
    
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    
    [self resetDotViews];
}

- (void)updateDotFrame:(UIView *)dot atIndex:(NSInteger)index
{
    // Dots are always centered within view
    CGFloat x = (self.dotSize.width + self.spacingBetweenDots) * index + ( (CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    
    dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
}

#pragma mark - Utils


/**
 *  Generate a dot view and add it to the collection
 *
 *  @return The UIView object representing a dot
 */
- (UIView *)generateDotView
{
    UIView *dotView;
    
    if (self.dotViewClass) {
        dotView = [[self.dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];
        if ([dotView isKindOfClass:[AnimatedDotView class]] && self.dotColor) {
            ((AnimatedDotView *)dotView).dotColor = self.dotColor;
        }
    } else {
        dotView = [[UIImageView alloc] initWithImage:self.dotImage];
        dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
    }
    
    if (dotView) {
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }
    
    dotView.userInteractionEnabled = YES;
    return dotView;
}


/**
 *  Change activity state of a dot view. Current/not currrent.
 *
 *  @param active Active state to apply
 *  @param index  Index of dot for state update
 */
- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index
{
    if (self.dotViewClass) {
        AbstractDotView *abstractDotView = (AbstractDotView *)[self.dots objectAtIndex:index];
        if ([abstractDotView respondsToSelector:@selector(changeActivityState:)]) {
            [abstractDotView changeActivityState:active];
        } else {
//            DLog(@"Custom view : %@ must implement an 'changeActivityState' method or you can subclass %@ to help you.", self.dotViewClass, [AbstractDotView class]);
        }
    } else if (self.dotImage && self.dotImage) {
        UIImageView *dotView = (UIImageView *)[self.dots objectAtIndex:index];
        dotView.image = (active) ? self.dotImage : self.dotImage;
    }
}


- (void)resetDotViews
{
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    
    [self.dots removeAllObjects];
    [self updateDots];
}


- (void)hideForSinglePage
{
    if (self.dots.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

#pragma mark - Setters


- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    // Update dot position to fit new number of pages
    [self resetDotViews];
}


- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots
{
    _spacingBetweenDots = spacingBetweenDots;
    
    [self resetDotViews];
}


- (void)setCurrentPage:(NSInteger)currentPage
{
    // If no pages, no current page to treat.
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    
    // Pre set
    [self changeActivity:NO atIndex:_currentPage];
    _currentPage = currentPage;
    // Post set
    [self changeActivity:YES atIndex:_currentPage];
}


- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    [self resetDotViews];
    self.dotViewClass = nil;
}


- (void)setCurrentDotImage:(UIImage *)currentDotimage
{

    _dotImage = currentDotimage;
    [self resetDotViews];
    self.dotViewClass = nil;
}


- (void)setDotViewClass:(Class)dotViewClass
{
    _dotViewClass = dotViewClass;
    self.dotSize = CGSizeZero;
    [self resetDotViews];
}


#pragma mark - Getters


- (NSMutableArray *)dots
{
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }
    
    return _dots;
}


- (CGSize)dotSize
{
    // Dot size logic depending on the source of the dot view
    if (self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    } else if (self.dotViewClass && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        return _dotSize;
    }
    
    return _dotSize;
}


@end
