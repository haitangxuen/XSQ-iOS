//
//  HttpRequest+User.m
//  XSQ
//
//  Created by black_dex on 2016/10/29.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "HttpRequest+User.h"

@implementation HttpRequest (User)
- (void)requestCheckRegister:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
   return [self postWithURLString:@"http://222.240.1.133/wygl/mall/androidUser_isExistYonghu" parameters:parameters success:^(id responseObject) {
       
   } failure:^(NSError *error) {
       
   }];
}
@end
