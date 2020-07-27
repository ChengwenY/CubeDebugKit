//
//  CubeAppInfoPlugin.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeAppInfoPlugin.h"
#import "CubeAppInfoViewController.h"
#import "CubeHomeWindow.h"

@implementation CubeAppInfoPlugin

- (void)loadPlugin
{
    CubeAppInfoViewController *vc = [[CubeAppInfoViewController alloc] init];
    [[CubeHomeWindow sharedInstance] showPlugin:vc];
}

@end
