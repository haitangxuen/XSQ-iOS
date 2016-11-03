//
//  LeftListCell.m
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "LeftListCell.h"
#import "PublicMacro.h"
@implementation LeftListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundColor = ColorFromHex(0xF5F5F5);
    self.selectedBackgroundView.backgroundColor = JColor_White;
    self.sortName.textColor = ColorFromHex(0x9D9D9D);
    // Initialization code
}
+ (UINib*)nib{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}
+ (NSString*)identifier{
    return NSStringFromClass(self);
}
+ (CGFloat)height{
    return ([UIScreen mainScreen].bounds.size.height-64-50)/10;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
