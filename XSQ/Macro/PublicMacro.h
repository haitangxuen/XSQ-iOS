//
//  PublicMacro.h
//  XSQ
//
//  Created by black_dex on 2016/10/26.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <BlocksKit/UIView+BlocksKit.h>
#import "MBProgressHUD.h"
#import "UIView+FrameExpand.h"
#import "UIViewController+Helper.h"
#import "CommonUI.h"
#import "AppDelegate.h"
#import <MJRefresh/UIView+MJExtension.h>
#import "HttpRequest.h"
#import "UIImageView+WebCache.h"


#import "AppDevice.h"
#import "AppConfig.h"
#import "UserModule.h"

#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

#ifndef PublicMacro_h
#define PublicMacro_h

//颜色宏定义

//色值角度宏定义
#define COLOR(r,g,b,a)  ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])
#define SHORTCOLOR(r)  ([UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:(1)])
//十六进制转化颜色
#define ColorFromHex(s) ([UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0])


#define JRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define JRGBAColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define JRandColor JRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


#define JColor_White                SHORTCOLOR(0xff)
#define JColor_Orange               COLOR(0xff, 0x79, 0x19, 1)
#define JColor_Red                  COLOR(255, 84, 84, 1)
#define JColor_Black                SHORTCOLOR(0x33)
#define JColor_Gray                 SHORTCOLOR(0x66)
#define JColor_LightGray            SHORTCOLOR(0x99)
#define JColor_Green                COLOR(76,192,95,1)
#define JColor_Blue                 COLOR(0x56,0xba,0xfc,1)
#define JColor_Clear                [UIColor clearColor]


#define JColor_NavBar               ColorFromHex(0x0079C2)
#define JColor_Background           COLOR(0xf4, 0xf5, 0xf9, 1)
#define JColor_Line                 SHORTCOLOR(0xdd)
#define JColor_Select_Text          ColorFromHex(0x808080)

//字体宏定义
#define FONT(size)      [UIFont systemFontOfSize:(size)]
#define FONTBOLD(size)  [UIFont boldSystemFontOfSize:(size)]
#define FONTPX(px)      [UIFont systemFontOfSize:(px/1.193)]
#define FONTBOLDPX(px)  [UIFont boldSystemFontOfSize:(px/1.193)]

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define TEXT_SIZE(text, font) [text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define TEXT_SIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#define JFont_NavTitle              FONT(16)
#define JFont_Tabbar                FONT(11)

#define JFont_Large                 FONT(18)
#define JFont_Middle                FONT(16)
#define JFont_Small                 FONT(14)

#define JCornerRadius               5

//常用参数宏定义（主要为手机长宽）
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_HEAD                 64
#define SCREEN_HEIGHT_WITHOUTHEAD   (SCREEN_HEIGHT-64)
#define SCREEN_SCALE                ((SCREEN_WIDTH)/320)
#define SCREEN_OFFSET               64 //or 64 用于切换automaticallyAdjustsScrollViewInsets
#define STATUSBAR_HEIGHT            [[UIApplication sharedApplication] statusBarFrame].size.height

//提示框宏定义
#define SHOW_MESSAGE(msg) {\
MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];\
hud.mode=MBProgressHUDModeText;\
hud.label.text=msg;\
hud.removeFromSuperViewOnHide=YES;\
[hud hideAnimated:YES afterDelay:1];\
}

//其他
#define LINE_SIZE                   1/[[UIScreen mainScreen] scale]

//常用单例
#define kAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kUserModule         ((UserModule *)[UserModule sharedInstance])
#define kAppConfig          ((AppConfig *)[AppConfig sharedInstance])
#define kAppDevice          ((AppDevice *)[AppDevice sharedInstance])
#define kRequest            ((HttpRequest *)[HttpRequest sharedInstance])
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

//字符串处理宏定义
#define NON(str) (str?str:@"")
#define isEmpty(str) ([str isEqual:[NSNull null]] || str==nil || str.length==0)

//字典取数字宏定义（处理null问题）
#define isNSNull(obj) ((NSNull *)obj == [NSNull null])
#define DIC_NUM(obj) (isNSNull(obj) ? 0: [obj integerValue])

#endif /* PublicMacro_h */
