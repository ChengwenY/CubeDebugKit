//
//  CubeCrashSignalHandler.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/7/11.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeCrashSignalHandler : NSObject

+ (void)registerHandler;
@end

NS_ASSUME_NONNULL_END
