//
//  LeftListCell.h
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sortName;
+ (UINib*)nib;
+ (NSString*)identifier;
+ (CGFloat)height;
@end
