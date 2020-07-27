//
//  CubePluginProtocol.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/7.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CubePluginProtocol <NSObject>

@optional

- (void)loadPlugin;

- (void)loadPlugin:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
