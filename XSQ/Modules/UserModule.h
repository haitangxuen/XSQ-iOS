//
//  UserModule.h
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserModule : NSObject<NSCoding>

//单例
+ (UserModule *)sharedInstance;

//保持数据到文件
- (void)save;

@property (nonatomic, copy) NSString *userID;       //uid,内部ID
@property (nonatomic, copy) NSString *userToken;    //token

@property (nonatomic, copy) NSString *userPhone;    //注册手机号码
@property (nonatomic, copy) NSString *userAvatar;   //头像URL
@property (nonatomic, copy) NSString *userNick;     //昵称

@property (nonatomic, copy) NSString *userSex;      //性别
@property (nonatomic, copy) NSString *userBirthday; //生日
@property (nonatomic, copy) NSString *userAge;      //年龄
@property (nonatomic, copy) NSString *userRole;     //用户角色 0 普通用户 非0 艺人用户

@property (nonatomic, copy) NSString *userCity;     //城市
@property (nonatomic, copy) NSString *userAstronomy;    //星座
@property (nonatomic, copy) NSString *userIntraInfo;    //简介

@property (nonatomic, copy) NSString *wechatCode;   //微信登陆回调code
@property (nonatomic, copy) NSString *qqOpenId;     //QQ登陆回调code

@property (nonatomic, copy) NSString *weiboOpenId;  //微博登陆回调code
@property (nonatomic, copy) NSString *weiboExpirationDate;  //微博过期时间
@property (nonatomic, copy) NSString *weiboUserID;  //微博用户id

@property (nonatomic, copy) NSString *messageNum;   //消息数
@property (nonatomic, copy) NSString *wealthNum;    //芒果币
@property (nonatomic, copy) NSString *couponNum;    //优惠券数

//TODO: 未有人气值
@property (nonatomic,copy) NSString *popularityValues;//人气值


@property (nonatomic, copy) NSString *msgCount;//未读消息量
@property (nonatomic, copy) NSString *cardCount;//卡券数量
@property (nonatomic, copy) NSString *fansCount;//粉丝数量
@property (nonatomic, copy) NSString *addFansCount;//新增粉丝量
@property (nonatomic, copy) NSString *followCount;//我的关注数量
@property (nonatomic, copy) NSString *dyCount;//动态数量
@property (nonatomic, copy) NSString *dyMsgCount;//动态消息数量

- (BOOL)hasLogin;

- (void)logout;

- (void)requestUserInfo;

@end
