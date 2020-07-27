//
//  CubeCrashUtil.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/31.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeCrashUtil.h"

@implementation CubeCrashUtil

+ (void)saveExceptionLog:(NSString *)log fileName:(NSString *)fileName {
    
    if (log.length > 0 && fileName.length > 0) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        formatter.timeZone = [NSTimeZone systemTimeZone];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *crashDir = [self cacheDir];
        if (crashDir && [fm fileExistsAtPath:crashDir]) {
            
            NSString *crashPath = [crashDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Crash %@.txt", dateStr]];
            if (fileName.length > 0) {
                crashPath = [crashDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@ %@.txt", fileName, dateStr]];
            }
            
            [log writeToFile:crashPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }
}

+ (NSString *)cacheDir {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *directory = [cachePath stringByAppendingPathComponent:@"Crash"];
    
    NSFileManager *fm = [NSFileManager defaultManager];

    if (![fm fileExistsAtPath:directory]) {
        [fm createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directory;
}

@end
