//
//  SortLayout.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "SortLayout.h"

@implementation SortLayout
- (CGSize)itemSize{
    return CGSizeMake([UIApplication sharedApplication].keyWindow.bounds.size.width/4, 67);
}
- (CGFloat)minimumLineSpacing{
    return 0.0;
}
- (CGFloat)minimumInteritemSpacing{
    return 0.0;
}
- (UIEdgeInsets)sectionInset{
    return UIEdgeInsetsMake(500, 0, 0, 0);
}
- (UICollectionViewScrollDirection)scrollDirection{
    return UICollectionViewScrollDirectionHorizontal;
}
@end
