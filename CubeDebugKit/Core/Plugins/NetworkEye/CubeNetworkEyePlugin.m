//
//  NetworkEyePlugin.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/7.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeNetworkEyePlugin.h"
#import "NEHTTPEyeViewController.h"
#import "CubeHomeWindow.h"

@implementation CubeNetworkEyePlugin

- (void)loadPlugin
{
    NEHTTPEyeViewController *vc = [[NEHTTPEyeViewController alloc] init];
    [[CubeHomeWindow sharedInstance] showPlugin:vc];
}

@end
