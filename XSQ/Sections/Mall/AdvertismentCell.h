//
//  AdvertismentCell.h
//  XSQ
//
//  Created by black_dex on 2016/10/30.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface AdvertismentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
+ (UINib*)nib;

+ (NSString*)identifier;
@end
