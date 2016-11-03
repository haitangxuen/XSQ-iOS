//
//  XSQHomeData.m
//  XSQ
//
//  Created by black_dex on 2016/10/31.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQHomeData.h"
#import "PublicMacro.h"

@implementation XSQHomeData

@end

@implementation XSQHomeAdvertis

- (void)praseResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        id object = (NSDictionary*)responseObject[NON(@"lblist")];
        if ([object isKindOfClass:[NSArray class]]) {
            self.dataArray = [NSMutableArray array];
            self.dataArray = object;
        }
    }
}

@end

