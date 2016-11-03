//
//  SallHeaderCell.m
//  XSQ
//
//  Created by black_dex on 2016/10/30.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "SallHeaderCell.h"

@implementation SallHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (UINib*)nib{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}
+ (NSString*)identifier{
    return NSStringFromClass(self);
}
@end
