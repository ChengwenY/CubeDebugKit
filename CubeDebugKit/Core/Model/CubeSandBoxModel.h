//
//  CubeSandBoxModel.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CubeTypedef.h"

NS_ASSUME_NONNULL_BEGIN

@interface CubeSandBoxModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *size;

@property (nonatomic, assign) CubeSandBoxFileType type;
@end

NS_ASSUME_NONNULL_END
