//
//  XSQLoginViewController.h
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void (^BackIndexBlock)(NSInteger index);

typedef void (^LoginBlock)(id result);

@interface XSQLoginViewController : BaseViewController
@property (nonatomic, copy)BackIndexBlock backIndex;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (nonatomic, copy)LoginBlock loginBlock;

+ (void)LoadDefaultVcWithIndex:(BackIndexBlock)backIndex;

@end
