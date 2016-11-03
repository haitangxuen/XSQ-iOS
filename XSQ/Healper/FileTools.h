//
//  FileTools.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTools : NSObject

//缓存目录
+ (NSString *)cacheDirectory;

//文档目录
+ (NSString *)documentDirectory;

//创建文档目录中的子目录，pathName为相对路径，不能同时创建上级不存在的目录
+ (NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName;

//创建文档目录中的文件，fileName为相对路径，不能同时创建上级不存在的目录
+ (NSString *)createFileInDocumentDirectory:(NSString *)fileName;

//计算文件大小
+ (unsigned long long)fileSizeAtPath:(NSString*)filePath;

@end
