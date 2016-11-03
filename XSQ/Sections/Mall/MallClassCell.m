//
//  MallClassCell.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "MallClassCell.h"

@implementation MallClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (NSString *)identifier{
    return NSStringFromClass(self);
}
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

@end
