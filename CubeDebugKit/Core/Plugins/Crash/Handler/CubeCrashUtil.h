//
//  CubeCrashUtil.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/31.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeCrashUtil : NSObject

+ (void)saveExceptionLog:(NSString *)log fileName:(NSString *)fileName;

+ (NSString *)cacheDir;
@end

NS_ASSUME_NONNULL_END
