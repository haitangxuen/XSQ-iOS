//
//  SalesCell.h
//  XSQ
//
//  Created by black_dex on 2016/10/29.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
+ (NSString *)identifier;
+ (UINib *)nib;
@end
