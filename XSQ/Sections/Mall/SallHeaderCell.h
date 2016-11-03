//
//  SallHeaderCell.h
//  XSQ
//
//  Created by black_dex on 2016/10/30.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SallHeaderCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *salesEveryDLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
+ (UINib*)nib;

+ (NSString*)identifier;
@end
