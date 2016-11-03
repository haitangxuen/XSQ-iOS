//
//  XSQMallViewController.h
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockIndex)(NSInteger index);

@interface XSQMallViewController : UIViewController

@property (nonatomic, assign)BlockIndex blockIndex;

@end
