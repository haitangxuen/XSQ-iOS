//
//  HttpRequest.m
//  XSQ
//
//  Created by black_dex on 2016/10/28.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "UploadParam.h"
#import <AFHTTPSessionManager.h>
#import "PublicMacro.h"

static NSString * baseURLString = @"http://222.240.1.133/wygl/mall/";

#define URL(string)    [baseURLString stringByAppendingString:string]
@implementation HttpRequest

static id _instance = nil;
+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"位置网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    NSLog(@"当前2G/3G/4G网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                }
            }
        }];
    });
    return _instance;
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    /**
     *  可以接受的类型
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
//    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 30;
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [self parsedResponseObject:responseObject];
        if ([result isKindOfClass:NSError.class]) {
            failure(result);
        } else {
            NSLog(@"\nRESPONSE SUCCESS:\n%@",responseObject);
            success(result);
        }
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\nRESPONSE FAILURE:\n%@",error);
        failure(error);
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"\nRESPONSE SUCCESS:\n%@",responseObject);
        id result = [self parsedResponseObject:responseObject];
        if ([result isKindOfClass:NSError.class]) {
            failure(result);
        } else {
            success(result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\nRESPONSE FAILURE:\n%@",error);
        failure(error);
    }];
}

#pragma mark -- POST/GET网络请求 --
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failure(error);
            }];
        }
            break;
    }
}

- (void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray<UploadParam *> *)uploadParams success:(void (^)())success failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            id result = [self parsedResponseObject:responseObject];
            if ([result isKindOfClass:NSError.class]) {
                failure(result);
            } else {
                success(result);
            }
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
}

/**
 *  解析网络请求返回参数
 *
 *  @param responseObject 网络返回参数
 *
 *  @return 解析结果
 */
- (id)parsedResponseObject:(id)responseObject
{
    NSDictionary *dictResponse = nil;
    
    if ([responseObject isKindOfClass:NSData.class]) {
        NSError *error;
        dictResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];

        
        //        if (error) {
        
        //            return [[NSString alloc] initWithBytes:data.bytes
        //                                            length:data.length
        //                                          encoding:NSASCIIStringEncoding];
        //        }
    } else if ([responseObject isKindOfClass:NSDictionary.class]) {
        dictResponse = responseObject;
        return dictResponse;
    }
    
    if (dictResponse) {
        NSInteger code = [dictResponse[@"status"] integerValue];
        if (code == 0) {
            return dictResponse;
        } else {
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
            userInfo[NSLocalizedDescriptionKey] = dictResponse[@"MSG"];
            
            return [NSError errorWithDomain:@"CBClientErrorDomain" code:code userInfo:userInfo];
        }
    } else {
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
        userInfo[NSLocalizedDescriptionKey] = @"返回数据格式非法";
        
        return [NSError errorWithDomain:@"CBClientErrorDomain" code:9999 userInfo:userInfo];
    }
}
- (NSDictionary*)mapUrl{
    if (!_mapUrl) {
        _mapUrl = @{
                    
                    @"requestCheckRegister":URL(@"androidUser_isExistYonghu"),//是否注册
                    @"requestRegister":URL(@"androidUser_addUser"),//注册
                    @"requestLogin":URL(@"androidUser_isExistYonghu"),//登录
                    @"requestResetPassword":URL(@"androidUser_isExistYonghu"),//密码重置
                    @"requestResetNickName":URL(@"androidUser_mergeUser"),//修改昵称
                    @"requestCollectProducts":URL(@"collection_addCollection"),//收藏商品
                    @"requestDeleteCollection":URL(@"collection_deleteCollection"),//删除收藏商品
                    @"requestHomeProduct":URL(@"androidProduct_findHomeProduct"),//获取首页推荐商品集
                    @"requestProductDetail":URL(@"productDetail.jsp"),//获取商品详情网页
                    @"requestAddNewAdress":URL(@"add_saveAdd"),//新增收获地址
                    
                    @"requestCircleScrollInHome":URL(@"androidPeizhi_findAppMainLunBoTu"),//获取首页轮播图
                    @"requestCircleScrollAndIconInMall":URL(@"androidPeizhi_findAppScLunBoTu"),//获取商城轮播和图标
        
                    @"requestQueryTakeAdressWithUser":URL(@"add_findAdd"),//根据用户查询收获地址列表
                    @"requestDeleteAdressWithId":URL(@"add_deleteAdd"),//据地址Id删除地址
                    @"requestSetDefaultAdressWithId":URL(@"add_setDefaultAdd"),//根据地址id设置默认地址
                    @"requestRecharge":URL(@"androidUser_yonghuRecharge.action"),//充值接口
                    @"requestBankBalance":URL(@"androidUser_findUserInfoByid")//查询所有余额

                    
                                       };
    }
    return _mapUrl;
}
@end
