//
//  XSQSubMallData.h
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface XSQSubMallData : JSONModel@end

@interface XSQMallAdvertis : JSONModel

@property (nonatomic,strong)NSString <Optional> *mallPeizhiValue;

@property (nonatomic,strong)NSString <Optional> *mallPeizhiType;

@property (nonatomic,strong)NSString <Optional> *mallPeizhiBeiyong;

@property (nonatomic,strong)NSMutableArray <Optional> *dataArrar;



- (NSMutableArray*)praseResponseObject:(id)responseObject;
@end
