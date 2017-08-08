//
//  IndexViewTableViewCell.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "IndexViewTableViewCell.h"

#import "IndexModel.h"

@interface IndexViewTableViewCell()<CycleScrollViewDelegate>

@property (nonatomic, strong) CycleScrollView *cycleScrollView;

@end
@implementation IndexViewTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenWidth] * 43/72) imageURLStringsGroup:nil]; // 模拟网络延时情景
    [self.contentView addSubview:self.cycleScrollView];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.cycleScrollView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(IndexModel *)model {
    NSLog(@"穿过来的数组-----%@",self.picArr);
    if (self.picArr.count) {
        self.cycleScrollView.pageControlAliment = CycleScrollViewPageContolAlimentCenter;
        self.cycleScrollView.pageControlStyle = CycleScrollViewPageContolStyleClassic;
        self.cycleScrollView.delegate = self;
        //        self.cycleScrollView.dotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
        //        self.cycleScrollView.indicatorDotColor = [UIColor whiteColor];
        self.cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
        self.cycleScrollView.autoScrollTimeInterval = 4.0;
        //        self.cycleScrollView.hidesForSinglePage = YES;
        self.cycleScrollView.imageURLStringsGroup = self.picArr;
        if (1 == self.picArr.count) {
            self.cycleScrollView.autoScroll = NO;
        }
    }
}
#pragma mark - 轮滚点击代理
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.IndexViewCellDelegate didselectADPic:index];
}

@end
