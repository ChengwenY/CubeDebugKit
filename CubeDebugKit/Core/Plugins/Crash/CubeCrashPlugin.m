//
//  CubeCrashPlugin.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/31.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeCrashPlugin.h"
#import "CubeCrashViewController.h"
#import "CubeHomeWindow.h"

@implementation CubeCrashPlugin

- (void)loadPlugin
{
    CubeCrashViewController *vc = [[CubeCrashViewController alloc] init];
    
    [[CubeHomeWindow sharedInstance] showPlugin:vc];
}

@end
