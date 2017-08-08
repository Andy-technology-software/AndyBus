//
//
//  
//
//  Created by 徐仁强 on 15/8/16.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyController : NSObject
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
+(UIView*)viewWithFrame:(CGRect)frame;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
+(float)isIOS7;
+(float)StatusBar;
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;
+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;
+ (NSString *)addOneByIntegerString:(NSString *)integerString;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
+(void)HelpfulHints:(NSString*)text addView:(UIView*)addView;
+ (int)convertToInt:(NSString*)strtemp;
+ (NSString *)stringFromDate:(NSDate *)date;
+(NSString*)formatString:(NSString*)timeString;
+(NSDate *)dateFromString:(NSString *)timeString formate:(NSString*)formate;
+(NSString *)stringFromDate:(NSDate *)date formate:(NSString*)formate;
+ (BOOL) isBlankString:(NSString *)string;
+ (BOOL)fileExists:(NSString *)fullPathName;
+ (BOOL)remove:(NSString *)fullPathName;
+ (void)makeDirs:(NSString *)dir;
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName;
+ (NSString*)documentPath:(NSString*)fileName;
+ (BOOL)deleteDocumentFile:(NSString*)fileName;
+ (BOOL)fileExistInCachesPath:(NSString*)fileName;
+ (NSString*)cachesFilePath:(NSString*)fileName;
+ (BOOL)deleteCachesFile:(NSString*)fileName;
+ (NSString *)convertDateFromCST:(NSString *)_date;
+ (NSString *)encodeTime:(NSDate *)date;
+ (NSDate *)dencodeTime:(NSString *)dateString;
+ (NSString *)dencodeDateStr:(NSString *)dateStr format:(NSString *)format;
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format;
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format;
+ (NSString *)timeSinceNow:(NSDate *)date;
+ (NSString *)changeSecondsToString:(CGFloat)durartion;
+ (void)goToAppStoreHomePage:(NSInteger)appid;
+ (void)goToAppStoreCommentPage:(NSInteger)appid;
+ (void)goToSmsPage:(NSString*)phoneNumber;
+ (void)openBrowse:(NSString*)url;
+ (void)openEmail:(NSString*)email;
+ (NSString*)getSize:(NSNumber*)number;
+ (CGFloat)freeDiskSpace;
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max;
+ (CGFloat)returnHeightFloat:(NSString *)str frontSize:(UIFont*)front frontWidth:(CGFloat)frontwidth;
+ (NSString *)macAddress;
+ (NSString *)encode:(NSString *)s;
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize;
+ (NSString *)systemTime:(NSString *)format;//time  string>string
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+ (CATransition *)creatAnmitionFrom:(NSInteger)direction;
+ (CATransition *)creatAnmitionHorizontalFrom:(NSInteger)direction;
+ (CATransition *)creatAnmitionDisplayScreenView:(NSInteger)direction;
+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic;
+ (NSString *)returnStr:(id)object;
+ (NSMutableAttributedString *)changeText:(NSString *)countStr content:(NSString *)content changeTextFont:(UIFont *)changeTextFont textFont:(UIFont *)textFont changeTextColor:(UIColor *)changeTextColor textColor:(UIColor *)textColor;
+(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSArray *)arraryWithJsonString:(NSString *)jsonString;
+ (NSString*)getUserid;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
