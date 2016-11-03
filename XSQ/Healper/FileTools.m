//
//  FileTools.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "FileTools.h"

@implementation FileTools

+ (NSString *)cacheDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)documentDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName
{
    NSString *doc = [self documentDirectory];
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *path = [doc stringByAppendingPathComponent:pathName];
    if(![fileHandle fileExistsAtPath:path]) {
        NSError *error;
        if([fileHandle createDirectoryAtPath:path withIntermediateDirectories:false attributes:nil error:&error]) {
            
        }
        else {
            return nil;
        }
    }
    return path;
}

+ (NSString *)createFileInDocumentDirectory:(NSString *)fileName
{
    
    NSString *doc = [self documentDirectory];
    NSFileManager *fileHandle = [NSFileManager defaultManager];
    NSString *path = [doc stringByAppendingPathComponent:fileName];
    if(![fileHandle fileExistsAtPath:path]) {
        if([fileHandle createFileAtPath:path contents:nil attributes:nil]) {
            
        }
        else {
            return nil;
        }
    }
    return path;
}

+ (unsigned long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
