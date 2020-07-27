//
//  CubeBaseViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/7.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeBaseViewController.h"
#import "UIImage+Cube.h"

@interface CubeBaseViewController ()

@end

@implementation CubeBaseViewController

- (void)loadView
{
    [super loadView];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage cube_imageNamed:@"cube-back"];
    [button setImage:image forState:UIControlStateNormal];
    [button.widthAnchor constraintEqualToConstant:40].active = YES;
    [button.heightAnchor constraintEqualToConstant:44].active = YES;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -(40-image.size.width)/2, 0, 0);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
