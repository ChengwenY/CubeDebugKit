//
//  NetworkTestViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "NetworkTestViewController.h"
#import "UIView+Cube.h"

@interface NetworkTestViewController ()<NSURLConnectionDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) UIButton *btn0;

@end

@implementation NetworkTestViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"网络测试";
    
    self.btn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn0 setBackgroundColor:[UIColor purpleColor]];
    [self.btn0 setTitle:@"发送一条URLConnection请求" forState:UIControlStateNormal];
    [self.btn0 addTarget:self action:@selector(sendUrlConnection) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        self.btn0.frame = CGRectMake(0, 10 + self.view.safeAreaInsets.top, self.view.cube_width, 60);
    } else {
        // Fallback on earlier versions
        self.btn0.frame = CGRectMake(0, 64 + 10, self.view.cube_width, 60);
    }
}

- (void)sendUrlConnection
{
    NSURL *url = [NSURL URLWithString:@"https://www.taobao.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        NSLog(@"response = %@ \n", data);
    }];
    
}


@end
