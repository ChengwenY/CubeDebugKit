//
//  DemoViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "DemoViewController.h"
#import "NetworkTestViewController.h"
#import "SandBoxTestViewController.h"
#import "CrashViewController.h"

@interface DemoViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DoraemonKit";
    self.navigationItem.leftBarButtonItems = nil;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *txt = nil;
    NSInteger row = indexPath.row;
    if (row==0) {
        txt = @"网络测试";
    }
    else if(row==1){
        txt = @"沙盒测试";
    }
    else if(row==2){
        txt = @"crash测试";
    }
//    else if(row==3){
//        txt = @"视觉测试Demo";
//    }else if(row==4){
//        txt = @"网络测试Demo";
//    }else if(row==5){
//        txt = @"模拟位置Demo";
//    }else if(row==6){
//        txt = @"crash触发Demo";
//    }else if(row==7){
//        txt = @"通用测试Demo";
//    }
    cell.textLabel.text = txt;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UIViewController *vc = nil;
    if (row == 0) {
        vc = [[NetworkTestViewController alloc] init];
    }
    else if (row == 1)
    {
        vc = [[SandBoxTestViewController alloc] init];
    }
    else if(row == 2){
        vc = [[CrashViewController alloc] init];
    }
//    else if(row == 2){
//        vc = [[DoraemonDemoPerformanceViewController alloc] init];
//    }else if(row == 3){
//        vc = [[DoraemonDemoUIViewController alloc] init];
//    }else if(row == 4){
//        vc = [[DoraemonDemoNetViewController alloc] init];
//    }else if(row == 5){
//        vc = [[DoraemonDemoMockGPSViewController alloc] init];
//    }else if(row == 6){
//        vc = [[DoraemonDemoCrashViewController alloc] init];
//    }else{
//        vc = [[DoraemonDemoCommonViewController alloc] init];
//    }
    [self.navigationController pushViewController:vc animated:YES];
}




@end
