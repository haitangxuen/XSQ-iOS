//
//  XSQHomeData.h
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface XSQHomeData : NSObject@end


@interface XSQHomeAdvertis : JSONModel

@property (nonatomic,strong)NSString <Optional>*mallPeizhiValue;

@property (nonatomic,strong)NSMutableArray <Optional>*dataArray;

- (void)praseResponseObject:(id)responseObject;

@end
