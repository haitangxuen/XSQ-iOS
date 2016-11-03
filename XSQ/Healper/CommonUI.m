//
//  CommonUI.m
//  GoShop
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 com.black.tree. All rights reserved.
//

#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommonUI

+ (UILabel *)commonLabelWithFrame:(CGRect)frame
                             text:(NSString*)text
                            color:(UIColor*)color
                             font:(UIFont*)font
                    textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = textAlignment;
    
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

+ (UITextField *)commonTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString*)placeholder
                                    color:(UIColor*)color
                                     font:(UIFont*)font
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = font;
    textField.secureTextEntry = secureTextEntry;
    textField.delegate = delegate;
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return textField;
}

+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString*)text
                                  color:(UIColor*)color
                                   font:(UIFont*)font
                          textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *txt = [[UITextView alloc] initWithFrame:frame];
    txt.text = text;
    txt.textColor = color;
    txt.font = font;
    txt.textAlignment = textAlignment;
    txt.backgroundColor = [UIColor clearColor];
    txt.editable = NO;
    txt.scrollEnabled = NO;
    txt.dataDetectorTypes = UIDataDetectorTypeLink;
    
    return txt;
}

+ (UIButton*) commonButtonWithFrame:(CGRect)frame
                              image:(UIImage*)image
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn= [[UIButton alloc] initWithFrame:frame];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                              image:(UIImage*)image
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn= [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIButton *)commonCenterControlButtonWithFrame:(CGRect)frame
                                            text:(NSString*)text
                                           color:(UIColor*)color
                                            font:(UIFont*)font
                                           image:(UIImage*)image
                                         spacing:(float)spacing
                                          target:(id)target
                                          action:(SEL)action
{
    UIButton *btn= [self commonButtonWithFrame:frame
                                          text:text
                                         color:color
                                          font:font
                                         image:image
                                        target:target
                                        action:action];
    
    CGSize txtSize = TEXT_SIZE(text, font);
    CGSize imgSize = image.size;
    CGFloat totalHeight = (imgSize.height + txtSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(imgSize.height-totalHeight, 0, 0, -txtSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imgSize.width, txtSize.height-totalHeight, 0);
    
    return btn;
}



+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn= [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                              block:(void (^)(UIButton* btn))block
{
    UIButton *btn= [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:JColor_Blue forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        block(input);
        return [RACSignal empty];
    }];
    
    return btn;
}

+ (UIButton *)commonButtonWithFrame:(CGRect)frame
                               text:(NSString*)text
                              color:(UIColor*)color
                        selectColor:(UIColor*)selectColor
                               font:(UIFont*)font
                    backgroundImage:(UIImage*)backgroundImage
                              block:(void (^)(UIButton* btn))block
{
    UIButton *btn= [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        block(input);
        return [RACSignal empty];
    }];
    
    return btn;
}


//+ (UISearchBar *)commonSearchBarWithFrame:(CGRect)frame
//                              placeholder:(NSString*)placeholder
//                          backgroundColor:(UIColor*)backgroundColor
//                                 delegate:(id)delegate
//{
//    UISearchBar *search = [[UISearchBar alloc] initWithFrame:frame];
//    search.placeholder = placeholder;
//    
//    if (isiOS8) {
//        for(UIView *v in [search subviews]) {
//            for(UIView *vv in [v subviews]) {
//                if([vv isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//                    [vv removeFromSuperview];
//                    break;
//                }
//            }
//        }
//        
//        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 8, search.width, search.height-16)];
//        border.backgroundColor = [UIColor clearColor];
//        border.layer.cornerRadius = 5;
//        border.layer.borderColor = SHORTCOLOR(200).CGColor;
//        border.layer.borderWidth = 0.5;
//        border.layer.masksToBounds = YES;
//        border.userInteractionEnabled = NO;
//        [search addSubview:border];
//    } else if(isiOS7) {
//        for(UIView *v in [search subviews]) {
//            for(UIView *vv in [v subviews]) {
//                if([vv isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//                    [vv removeFromSuperview];
//                    break;
//                }
//            }
//        }
//        
//        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(8, 8, search.width-16, search.height-16)];
//        border.backgroundColor = [UIColor clearColor];
//        border.layer.cornerRadius = 5;
//        border.layer.borderColor = SHORTCOLOR(200).CGColor;
//        border.layer.borderWidth = 0.5;
//        border.layer.masksToBounds = YES;
//        border.userInteractionEnabled = NO;
//        [search addSubview:border];
//    } else {
//        for(UIView *v in [search subviews]) {
//            if(![v isKindOfClass:[UITextField class]]) {
//                [v removeFromSuperview];
//            } else {
//                UITextField *txt = (UITextField *)v;
//                txt.backgroundColor = [UIColor whiteColor];
//                txt.background = nil;
//                txt.layer.cornerRadius = 5;
//                txt.layer.borderColor = SHORTCOLOR(200).CGColor;
//                txt.layer.borderWidth = 0.5;
//                txt.clearButtonMode = UITextFieldViewModeAlways; //编辑时会出现个修改X
//            }
//        }
//    }
//    
//    search.backgroundColor = backgroundColor;
//    search.backgroundImage = nil;
//    search.delegate = delegate;
//    
//    return search;
//}

+ (UIView*) commonLineViewWithFrame:(CGRect)frame
                              color:(UIColor*)color
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
    img.image = [self imageWithColor:color];
    return img;
}

+ (UIView*) commonViewWithFrame:(CGRect)frame
                          color:(UIColor*)color
{
    UIView *tCtrl = [[UIView alloc] initWithFrame:frame];
    tCtrl.backgroundColor = color;
    
    return tCtrl;
}


+ (UIView*) commonGroupViewWithFrame:(CGRect)frame
                          lineHeight:(CGFloat)lineHeight
                               color:(UIColor*)color
                           lineColor:(UIColor*)lineColor
{
    UIView *tCtrl = [[UIView alloc] initWithFrame:frame];
    tCtrl.backgroundColor = color;
    tCtrl.layer.cornerRadius = 6;
    tCtrl.layer.masksToBounds = YES;
    tCtrl.layer.borderWidth = LINE_SIZE;
    tCtrl.layer.borderColor = [lineColor CGColor];
    
    CGFloat t = lineHeight;
    while (t < tCtrl.frame.size.height) {
        UIView *line1 = [CommonUI commonLineViewWithFrame:CGRectMake(0, t, tCtrl.frame.size.width, 1) color:lineColor];
        [tCtrl addSubview:line1];
        t += lineHeight;
    }
    
    return tCtrl;
}

+ (UIImageView*) commonImageViewWithFrame:(CGRect)frame
                                    image:(UIImage*)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    
    return imgView;
}

+ (UIImage*) imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage*) imageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
