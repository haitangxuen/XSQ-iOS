//
//  MallClassCell.h
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallClassCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sortImageView;
@property (weak, nonatomic) IBOutlet UILabel *sortName;
+ (NSString *)identifier;
+ (UINib *)nib;
@end
