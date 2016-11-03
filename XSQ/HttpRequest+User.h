//
//  HttpRequest+User.h
//  XSQ
//
//  Created by black_dex on 2016/10/29.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "HttpRequest.h"

@interface HttpRequest (User)
- (void)requestCheckRegister:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
