//
//  CubeFileUtil.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeFileUtil.h"

@implementation CubeFileUtil

+ (NSString *)formatteredSizeAtFilePath:(NSString *)path
{
    long long size = [self sizeAtFilePath:path];
    
    NSString *formatterSize = [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleBinary];
    return formatterSize;
}

+ (long long)sizeAtFilePath:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    long long size = 0;
    if (fileExist)
    {
        if (isDirectory)
        {
            NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
            
            for (NSString *subPathComponent in files) {
                
                NSString *subPath = [path stringByAppendingPathComponent:subPathComponent];
                
                size += [self sizeAtFilePath:subPath];
            }
        }
        else
        {
            NSError *error = nil;
            NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
            NSNumber *fileSizeNumber = [fileAttr objectForKey:NSFileSize];
            long long fileSize = fileSizeNumber.longLongValue;
            return fileSize;
        }
    }
    return size;
}

@end
