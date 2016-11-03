//
//  CommonUI.h
//  GoShop
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 com.black.tree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMacro.h"

@interface CommonUI : NSObject

+ (UILabel *)commonLabelWithFrame:(CGRect)frame
                             text:(NSString*)text
                            color:(UIColor*)color
                             font:(UIFont*)font
                    textAlignment:(NSTextAlignment)textAlignment;

+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString*)text
                                  color:(UIColor*)color
                                   font:(UIFont*)font
                          textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString*)placeholder
                                    color:(UIColor*)color
                                     font:(UIFont*)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate;

+ (UIButton*) commonButtonWithFrame:(CGRect)frame
                              image:(UIImage*)image
                             target:(id)target
                             action:(SEL)action;

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                              image:(UIImage*)image
                             target:(id)target
                             action:(SEL)action;

+ (UIButton *)commonCenterControlButtonWithFrame:(CGRect)frame
                                            text:(NSString*)text
                                           color:(UIColor*)color
                                            font:(UIFont*)font
                                           image:(UIImage*)image
                                         spacing:(float)spacing
                                          target:(id)target
                                          action:(SEL)action;

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                             target:(id)target
                             action:(SEL)action;

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                              block:(void (^)(UIButton* btn))block;

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                        selectColor:(UIColor*)selectColor
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                              block:(void (^)(UIButton* btn))block;

//+ (UISearchBar *)commonSearchBarWithFrame:(CGRect)frame
//                              placeholder:(NSString*)placeholder
//                          backgroundColor:(UIColor*)backgroundColor
//                                 delegate:(id)delegate;

+ (UIView*)commonLineViewWithFrame:(CGRect)frame
                             color:(UIColor*)color;

+ (UIView*)commonViewWithFrame:(CGRect)frame
                         color:(UIColor*)color;

+ (UIView*)commonGroupViewWithFrame:(CGRect)frame
                         lineHeight:(CGFloat)lineHeight
                              color:(UIColor*)color
                          lineColor:(UIColor*)lineColor;

+ (UIImageView*) commonImageViewWithFrame:(CGRect)frame
                                    image:(UIImage*)image;

+ (UIImage*)imageWithColor:(UIColor*)color;

+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size;


@end
