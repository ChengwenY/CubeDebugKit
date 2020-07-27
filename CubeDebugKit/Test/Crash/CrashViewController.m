//
//  CrashViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/7/17.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CrashViewController.h"
#import "CubeHeader.h"

@interface CrashViewController ()

@end

typedef struct Test
{
    int a;
    int b;
}Test;

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, 60)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"Signal Exception" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(signalException) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, btn.cube_bottom+20, self.view.cube_width, 60)];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"Uncaught Exception" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(uncaughtException) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)signalException {
        Test *pTest = {1,2};
        free(pTest);
        pTest->a = 5;
    
    char *s = "hello";
    *s = 'H';
}

- (void)uncaughtException {
    
    NSArray *arr = @[];
    [arr objectAtIndex:1];
}

@end
