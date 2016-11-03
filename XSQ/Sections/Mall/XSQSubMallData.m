//
//  XSQSubMallData.m
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQSubMallData.h"
#import "PublicMacro.h"

@implementation XSQSubMallData

@end

@implementation XSQMallAdvertis
- (NSMutableArray *)praseResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary*)responseObject;
        id object = dic[NON(@"tblist")];
        self.dataArrar = [NSMutableArray array];
        if (object){
            [self.dataArrar addObject:object];
        }
        id ob = dic[NON(@"lblist")];
        if (ob) {
            [self.dataArrar addObject:ob];
        }
        return self.dataArrar;
    }
    if ([responseObject isKindOfClass:[NSArray class]]) {
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary*)responseObject;
                
            }
        }];
    }
    return nil;
}
@end
