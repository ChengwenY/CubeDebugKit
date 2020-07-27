//
//  HaloMemoryMonitorManager.h
//  HaloSlim
//
//  Created by Chengwen.Y on 16/9/18.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CubeDebugManager : NSObject

+ (instancetype)sharedInstance;
- (void)initEntryView;
- (void)install;
@end
