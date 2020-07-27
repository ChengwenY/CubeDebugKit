//
//  CubeStatusBarViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeStatusBarViewController.h"

@interface CubeStatusBarViewController ()

@end

@implementation CubeStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
