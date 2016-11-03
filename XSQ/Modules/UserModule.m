//
//  UserModule.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "UserModule.h"
#import "FileTools.h"

#define kUserSaveFile       @"saveUser.archive"
#define kSaveArchiverKey    @"ThinkDIT_SaveArchiver"

@implementation UserModule

+ (NSString *)userSaveFilePath {
    NSString *path = [FileTools createDirectoryInDocumentDirectory:@"logUsers"];
    NSString *filePath = [path stringByAppendingPathComponent:kUserSaveFile];
    return filePath;
}

+ (UserModule *)sharedInstance
{
    static UserModule *s_g_Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [UserModule userSaveFilePath];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        if(!data) {
            s_g_Instance = [[UserModule alloc] init];
        } else {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            s_g_Instance = [unarchiver decodeObjectForKey:kSaveArchiverKey];
            [unarchiver finishDecoding];
        }
    });
    return s_g_Instance;
}

- (void)save
{
    NSString *filePath = [UserModule userSaveFilePath];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:kSaveArchiverKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:true];
}

//#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.userToken = [decoder decodeObjectForKey:@"userToken"];
        
        self.userPhone = [decoder decodeObjectForKey:@"userPhone"];
        self.userAvatar = [decoder decodeObjectForKey:@"userAvatar"];
        self.userNick = [decoder decodeObjectForKey:@"userNick"];
        
        self.userSex = [decoder decodeObjectForKey:@"userSex"];
        self.userBirthday = [decoder decodeObjectForKey:@"userBirthday"];
        self.userAge = @""; // TODO
        self.userRole = [decoder decodeObjectForKey:@"userRole"];
        
        self.messageNum = [decoder decodeObjectForKey:@"messageNum"];
        self.wealthNum = [decoder decodeObjectForKey:@"wealthNum"];
        self.couponNum = [decoder decodeObjectForKey:@"couponNum"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.userID forKey:@"userID"];
    [coder encodeObject:self.userToken forKey:@"userToken"];
    
    [coder encodeObject:self.userPhone forKey:@"userPhone"];
    [coder encodeObject:self.userAvatar forKey:@"userAvatar"];
    [coder encodeObject:self.userNick forKey:@"userNick"];
    
    [coder encodeObject:self.userSex forKey:@"userSex"];
    [coder encodeObject:self.userBirthday forKey:@"userBirthday"];
    [coder encodeObject:self.userRole forKey:@"userRole"];
    
    [coder encodeObject:self.messageNum forKey:@"messageNum"];
    [coder encodeObject:self.wealthNum forKey:@"wealthNum"];
    [coder encodeObject:self.couponNum forKey:@"couponNum"];
}

- (void)logout
{
    self.userID = nil;
    self.userToken = nil;
    
    self.userPhone = nil;
    self.userAvatar = nil;
    self.userNick = nil;
    
    self.userRole = nil;
    
    self.wechatCode = nil;
    self.qqOpenId = nil;
    self.weiboOpenId = nil;
    
    self.msgCount = nil;
    self.cardCount = nil;
    self.fansCount = nil;
    self.addFansCount = nil;
    self.followCount = nil;
    self.dyCount = nil;
    self.dyMsgCount = nil;
    
    [self save];
}

- (BOOL)hasLogin
{
    BOOL bRet = (self.userID != nil) && (self.userID.length > 0) && (self.userToken != nil) && (self.userToken.length > 0);
    return bRet;
}
- (void)requestUserInfo{
    
}
@end

