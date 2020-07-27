//
//  CubeSandBoxPlugin.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeSandBoxPlugin.h"
#import "CubeSandBoxViewController.h"
#import "CubeHomeWindow.h"

@implementation CubeSandBoxPlugin

- (void)loadPlugin
{
    CubeSandBoxViewController *vc = [[CubeSandBoxViewController alloc] init];
    [[CubeHomeWindow sharedInstance] showPlugin:vc];
}

@end
