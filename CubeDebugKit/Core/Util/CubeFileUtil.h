//
//  CubeFileUtil.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeFileUtil : NSObject

+ (NSString *)formatteredSizeAtFilePath:(NSString *)path;

+ (long long)sizeAtFilePath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
