//
//  
//
//
//  Created by 徐仁强 on 15/8/16.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import "MyController.h"
#import  <dlfcn.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import  <CommonCrypto/CommonCryptor.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#import <objc/runtime.h>

#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@implementation MyController

+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=1;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=NO;
    label.text=text;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView* aimageView=[[UIImageView alloc]initWithFrame:frame];
    aimageView.image=[UIImage imageNamed:imageName];
    aimageView.userInteractionEnabled=YES;
    return aimageView;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    return view;
}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField;
    
}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*text= [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    text.background=[UIImage imageNamed:imageName];
    return  text;
    
}
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView;
}
+(UIPageControl*)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider;
}
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma -mark 判断导航的高度
+(float)isIOS7{
    
    float height;
    if (IOS7) {
        height=64.0;
    }else{
        height=44.0;
    }
    
    return height;
}

+(float)StatusBar{
    float height;
    if (IOS7) {
        height = 20.0;
    }else{
        height = 0;
    }
    return height;
}
//+(NSString *)platformString{
//    // Gets a string with the device model
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
//    NSDictionary* d = nil;
//    if (d == nil)
//    {
//        d = @{
//              @"iPhone1,1": @"iPhone 2G",
//              @"iPhone1,2": @"iPhone 3G",
//              @"iPhone2,1": @"iPhone 3GS",
//              @"iPhone3,1": @"iPhone 4",
//              @"iPhone3,2": @"iPhone 4",
//              @"iPhone3,3": @"iPhone 4 (CDMA)",
//              @"iPhone4,1": @"iPhone 4S",
//              @"iPhone5,1": @"iPhone 5",
//              @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
//
//              @"iPod1,1": @"iPod Touch (1 Gen)",
//              @"iPod2,1": @"iPod Touch (2 Gen)",
//              @"iPod3,1": @"iPod Touch (3 Gen)",
//              @"iPod4,1": @"iPod Touch (4 Gen)",
//              @"iPod5,1": @"iPod Touch (5 Gen)",
//
//              @"iPad1,1": @"iPad",
//              @"iPad1,2": @"iPad 3G",
//              @"iPad2,1": @"iPad 2 (WiFi)",
//              @"iPad2,2": @"iPad 2",
//              @"iPad2,3": @"iPad 2 (CDMA)",
//              @"iPad2,4": @"iPad 2",
//              @"iPad2,5": @"iPad Mini (WiFi)",
//              @"iPad2,6": @"iPad Mini",
//              @"iPad2,7": @"iPad Mini (GSM+CDMA)",
//              @"iPad3,1": @"iPad 3 (WiFi)",
//              @"iPad3,2": @"iPad 3 (GSM+CDMA)",
//              @"iPad3,3": @"iPad 3",
//              @"iPad3,4": @"iPad 4 (WiFi)",
//              @"iPad3,5": @"iPad 4",
//              @"iPad3,6": @"iPad 4 (GSM+CDMA)",
//
//              @"i386": @"Simulator",
//              @"x86_64": @"Simulator"
//              };
//    }
//    NSString* ret = [d objectForKey: platform];
//
//    if (ret == nil)
//    {
//        return platform;
//    }
//    return ret;
//}

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval {
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init] ;
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}
#pragma mark - 返回动态的高度
+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize {
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height + 5;
}
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
#pragma mark- 获取屏幕的宽
+(CGFloat)getScreenWidth{
    
    return [UIScreen mainScreen].bounds.size.width;
}
#pragma mark- 获取屏幕的高
+(CGFloat)getScreenHeight{
    
    return [UIScreen mainScreen].bounds.size.height;
}
#pragma mark - 两个时间的前后
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}
#pragma mark - 弹出一个提示框  底色可自己改变
+(void)HelpfulHints:(NSString*)text addView:(UIView*)addView{
    UILabel  * Alertlabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-80, SCREENHEIGHT/2-40, 160, 80)];
    //    Alertlabel.backgroundColor = [UIColor orangeColor];
    Alertlabel.backgroundColor = [MyController colorWithHexString:@"005bb6"];
    Alertlabel.textColor = [UIColor whiteColor];
    Alertlabel.font = [UIFont boldSystemFontOfSize:14];
    Alertlabel.text = text;
    [addView addSubview:Alertlabel];
    Alertlabel.textAlignment = NSTextAlignmentCenter;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    Alertlabel.alpha =0.0;
    [UIView commitAnimations];
}
+ (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}
#pragma mark - NSDate转字符串
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma - mark 根据字符串和格式，返回日期
+(NSDate *)dateFromString:(NSString *)timeString formate:(NSString*)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    return  [formatter dateFromString:timeString];
}
#pragma - mark 根据字符串日期，返回距离该日期时间间隔，几分钟，几小时之前
+(NSString*)formatString:(NSString*)timeString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSTimeInterval time =[[NSDate date] timeIntervalSinceDate:confromTimesp];
    //    如果小于一天
    if (time<24*60*60) {
        if (time < 60) {
            return [NSString stringWithFormat:@"刚刚"];
        }
        if (time<60*60) {
            return [NSString stringWithFormat:@"%d分钟前",(int)time/60];
        }
        return [NSString stringWithFormat:@"%d小时前",(int)time/60/60];
    }
    return [NSString stringWithFormat:@"%d天前",(int)time/60/60/24];
}
#pragma mark - 判断是不是空字符串
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


/**
 *	@brief	判断文件路径是否存在
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	返回是否存在
 */
+ (BOOL)fileExists:(NSString *)fullPathName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fullPathName];
}

/**
 *	@brief	删除文件
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	是否删除成功
 */
+ (BOOL)remove:(NSString *)fullPathName
{
    NSError *error = nil;
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:fullPathName]) {
        [file_manager removeItemAtPath:fullPathName error:&error];
    }
    if (error) {
        return NO;
    }
    return YES;
}

/**
 *	@brief	创建文件夹
 *
 *	@param 	dir 	文件夹名字
 */
+ (void)makeDirs:(NSString *)dir
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    [file_manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 *	@brief	判断Document文件路径是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回是否存在文件路径
 */
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName

{
    if(fileName == nil)
        return NO;
    NSString* documentsPath = [self documentPath:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath: documentsPath];
}

/**
 *	@brief	通过文件名，获取Document完整路径，如果不存在返回为nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回完整路径
 */
+ (NSString*)documentPath:(NSString*)fileName

{
    if(fileName == nil)
        return nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex: 0];
    NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
    return documentsPath;
}

/**
 *	@brief	删除Document文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否成功删除
 */
+ (BOOL)deleteDocumentFile:(NSString*)fileName

{
    BOOL del = NO;
    if(fileName == nil)
        return del;
    NSString* documentsPath = [self documentPath:fileName];
    if( [[NSFileManager defaultManager] fileExistsAtPath: documentsPath])
    {
        
        del = [[NSFileManager defaultManager] removeItemAtPath: documentsPath error:nil];
    }
    return del;
}

/**
 *	@brief	判断Cache是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否存在文件
 */
+ (BOOL)fileExistInCachesPath:(NSString*)fileName

{
    if(fileName == nil)
        return NO;
    NSString* cachesPath = [self cachesFilePath:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath: cachesPath];
}

/**
 *	@brief	通过文件名返回完整的Caches目录下的路径，如果不存在该路径返回nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回Caches完整路径
 */
+ (NSString* )cachesFilePath:(NSString*)fileName
{
    if(fileName == nil)
        return nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesdirectory = [paths objectAtIndex: 0];
    NSString* cachesPath = [cachesdirectory stringByAppendingPathComponent:fileName];
    return cachesPath;
}

/**
 *	@brief	删除Caches文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	删除是否成功
 */
+ (BOOL)deleteCachesFile:(NSString*)fileName

{
    BOOL del = NO;
    if(fileName == nil)
        return del;
    NSString* cachesPath = [self cachesFilePath:fileName];
    if( [[NSFileManager defaultManager] fileExistsAtPath: cachesPath])
    {
        del = [[NSFileManager defaultManager] removeItemAtPath: cachesPath error:nil];
    }
    return del;
}

/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	NSDate系统时间类型
 *
 *	@return	返回默认格式yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)encodeTime:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief	字符串格式化为时间格式
 *
 *	@param 	dateString 	默认格式yyyy-MM-dd HH:mm:ss
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

+ (NSString *)convertDateFromCST:(NSString *)_date
{
    if (_date == nil) {
        return nil;
    }
    //return nil;
    NSLog(@"_date==%@",_date);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss 'CST' yyyy"];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    
    NSDate *formatterDate = [inputFormatter dateFromString:_date];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    NSLog(@"newDateString==%@",newDateString);
    
    return newDateString;
}

/**
 *	@brief	离现在时间相差时间
 *
 *	@param 	date 	时间格式
 *
 *	@return	返回字符串
 */
+ (NSString *)timeSinceNow:(NSDate *)date{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeInterval interval = 0 - [date timeIntervalSinceNow];
        
        if (interval < 60) {
            // 几秒前
            return @"1分钟内";
        } else if (interval < (60 * 60)) {
            // 几分钟前
            return [NSString stringWithFormat:@"%u分钟前", (int)(interval / 60)];
        } else if (interval < (24 * 60 * 60)) {
            // 几小时前
            return [NSString stringWithFormat:@"%u小时前", (int)(interval / 60 / 60)];
        } else if (interval < (2 * 24 * 60 * 60)) {
            // 昨天
            [formatter setDateFormat:@"昨天"];
            return [formatter stringFromDate:date];
        } else if (interval < (3 * 24 * 60 * 60)) {
            // 前天
            [formatter setDateFormat:@"前天"];
            return [formatter stringFromDate:date];
            //    } else if (interval < (7 * 24 * 60 * 60)) {
            // 一星期内
        } else {
            // 具体时间
            NSInteger days = interval / (24 * 60 * 60);
            return [NSString stringWithFormat:@"%d天前",days];
        }
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief	把秒转化为时间字符串显示，播放器常用
 *
 *	@param 	durartion 	传入参数
 *
 *	@return	播放器播放进度时间，比如
 */
+ (NSString *)changeSecondsToString:(CGFloat)durartion
{
    int hh = durartion/(60 * 60);
    int mm = hh > 0 ? (durartion - 60*60)/60 : durartion/60;
    int ss = (int)durartion%60;
    NSString *hhStr,*mmStr,*ssStr;
    if (hh == 0) {
        hhStr = @"00";
    }else if (hh > 0 && hh < 10) {
        hhStr = [NSString stringWithFormat:@"0%d",hh];
    }else {
        hhStr = [NSString stringWithFormat:@"%d",hh];
    }
    if (mm == 0) {
        mmStr = @"00";
    }else if (mm > 0 && mm < 10) {
        mmStr = [NSString stringWithFormat:@"0%d",mm];
    }else {
        mmStr = [NSString stringWithFormat:@"%d",mm];
    }
    if (ss == 0) {
        ssStr = @"00";
    }else if (ss > 0 && ss < 10) {
        ssStr = [NSString stringWithFormat:@"0%d",ss];
    }else {
        ssStr = [NSString stringWithFormat:@"%d",ss];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hhStr,mmStr,ssStr];
}


/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	时间
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间字符串
 */
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
    
}

+ (NSString *)dencodeDateStr:(NSString *)dateStr format:(NSString *)format
{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        NSDate *date = [self dencodeTime:dateStr];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief  格式化成时间格式
 *
 *	@param 	dateString 	时间字符串
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

/**
 *	@brief	跳转到APPSTORE软件下载页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreHomePage:(NSInteger)appid

{
    NSString *str = [NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%u", appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/**
 *	@brief	跳转到APPSTORE软件评论页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreCommentPage:(NSInteger)appid

{
    NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%u", appid ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/**
 *	@brief	发短信
 *
 *	@param 	phoneNumber 	手机号码
 */
+ (void)goToSmsPage:(NSString*)phoneNumber

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
}

/**
 *	@brief	打开网页
 *
 *	@param 	url 	网页地址
 */
+ (void)openBrowse:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/**
 *	@brief	发送邮件
 *
 *	@param 	email 	email地址
 */
+ (void)openEmail:(NSString*)email;

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",email]]];
}

+ (CGFloat)freeDiskSpace
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:cachePath error:nil];
    float freeSpace = [[fileAttr objectForKey:NSFileSystemFreeSize] floatValue];
    return freeSpace;
    
}


/**
 *	@brief	通过字节获取文件大小
 *
 *	@param 	number 	字节数
 *
 *	@return	返回大小
 */
+ (NSString*)getSize:(NSNumber*)number

{
    NSInteger size=[number intValue];
    if(size<1024)
        return [NSString stringWithFormat:@"%uB", size];
    else
    {
        int size1=size/1024;
        if(size1<1024)
        {
            return [NSString stringWithFormat:@"%u.%uKB", size1,(size-size1*1024)/10];
        }
        else
        {
            int size2=size1/1024;
            if(size2<1024)
                return [NSString stringWithFormat:@"%u.%uMB", size2,(size1-size2*1024)/10];
        }
    }
    return nil;
}

/**
 *	@brief	获取随即数
 *
 *	@param 	min 	最小数值
 *	@param 	max 	最大数值
 *
 *	@return	返回数值
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max
{
    int value=0;
    if(min>0)
        value= (arc4random() % (max-min+1)) + min;
    else
        value= arc4random() % max;
    return value;
}

/**
 *	@brief	UILabel高度
 *
 *	@param 	str 	文字
 *	@param 	front 	字体
 *	@param 	frontwidth 	UILabel宽度
 *
 *	@return	返回高度
 */
+ (CGFloat)returnHeightFloat:(NSString *)str frontSize:(UIFont*)front frontWidth:(CGFloat)frontwidth
{
    CGSize asize = CGSizeMake(frontwidth,5000);
    CGSize labelsize = [str sizeWithFont:front constrainedToSize:asize lineBreakMode:0];
    return  labelsize.height;
}

/**
 *	@brief	mac地址
 *
 *	@return	返回地址
 */
+ (NSString *)macAddress

{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

/**
 *	@brief	转换字符串编码
 *
 *	@param 	s 	字符串
 *
 *	@return	返回UTF-8的编码
 */
+ (NSString *)encode:(NSString *)s {
    return  [s stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
}
/**
 * @brief 图片压缩
 *  UIGraphicsGetImageFromCurrentImageContext函数完成图片存储大小的压缩
 * Detailed
 * @param[in] 源图片；指定的压缩size
 * @param[out] N/A
 * @return 压缩后的图片
 * @note
 */
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize {
    
    CGFloat scale;
    CGSize newsize = image.size;
    if (newsize.height && (newsize.height > viewsize.height)) {
        scale = viewsize.height/newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    if (newsize.width && (newsize.width >= viewsize.width)) {
        scale = viewsize.width /newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    UIGraphicsBeginImageContext(viewsize);
    
    float dwidth = (viewsize.width - newsize.width)/2.0f;
    float dheight = (viewsize.height - newsize.height)/2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, newsize.width, newsize.height);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)systemTime:(NSString *)format {
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [[NSDate date] timeIntervalSince1970];
    [formatter setDateFormat:format];
    NSString *returnTime = [formatter stringFromDate:date];
    return returnTime;
}


+ (CATransition *)creatAnmitionFrom:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.type = kCATransitionPush;
    if (direction == 0) {
        animation.subtype = kCATransitionFromBottom;
    }else{
        animation.subtype = kCATransitionFromTop;
    }
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    return animation;
}

+ (CATransition *)creatAnmitionHorizontalFrom:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.type = kCATransitionPush;
    if (direction == 0) {
        animation.subtype = kCATransitionFromRight;
    }else{
        animation.subtype = kCATransitionFromLeft;
    }
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    return animation;
}

+ (CATransition *)creatAnmitionDisplayScreenView:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    if (direction == 0) {
        animation.type = kCATransitionFade;
    }else{
        animation.type = @"rippleEffect";
    }
    
    return animation;
}

//根据info属性名赋值
+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic
{
    unsigned int outCount ;
    objc_property_t *properties = class_copyPropertyList([infoObject class], &outCount);
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        
        //free((void *)propertyName);
        
        if ([jsonDic valueForKey:propertyNameStr] != nil)
        {
            [infoObject setValue:[jsonDic valueForKey:propertyNameStr] forKey:propertyNameStr];
        }
    }
    free(properties);
    return infoObject;
}

//去除null
+ (NSString *)returnStr:(id)object
{
    NSString *cnt = @"";
    if (![object isKindOfClass:[NSNull class]]) {
        if ([object isKindOfClass:[NSNumber class]]) {
            cnt = [NSString stringWithFormat:@"%@",object];
        }else {
            if ([object rangeOfString:@"null"].location == NSNotFound) {
                cnt = [NSString stringWithFormat:@"%@",object];
            }
        }
    }
    return cnt;
}

#pragma mark - 改变label颜色
/**
 *  改变label颜色        6.0及以上
 *
 *  @param countStr     要改变的部分             比如:1.4...
 *  @param content      总字符串                比如:1.4小时,学习1.4小时...
 *  @param propertyDict 要改变部分字体大小UIFont   @"changeTextFont"
 整体字体大小UIFont        @"textFont"
 要改变部分颜色UIColor     @"changeTextColor"
 整体部分颜色 UIColor      @"textColor"
 *
 *  @return 处理后的字符串 label.attributedText = 返回
 */
+ (NSMutableAttributedString *)changeText:(NSString *)countStr content:(NSString *)content changeTextFont:(UIFont *)changeTextFont textFont:(UIFont *)textFont changeTextColor:(UIColor *)changeTextColor textColor:(UIColor *)textColor
{
    NSMutableAttributedString *scanStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",content]];
    NSRange changeTextRange = [content rangeOfString:countStr];//需要改变字体的位置
    
    [scanStr addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, content.length)];
    [scanStr addAttribute:NSFontAttributeName value:changeTextFont range:NSMakeRange(changeTextRange.location, countStr.length)];
    
    [scanStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, content.length)];
    [scanStr addAttribute:NSForegroundColorAttributeName value:changeTextColor range:NSMakeRange(changeTextRange.location, countStr.length)];
    
    return scanStr;
}
//设置不同字体颜色
+(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    labell.attributedText = str;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSArray *)arraryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//+ (NSString*)getUserid{
//    LoginDataBaseModel* model = [[[DBManager shareManager] getAllLoginModel] firstObject];
//    if ([MyController isBlankString:model.userId]) {
//        return @"";
//    }
//    return model.userId;
//}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
@end
