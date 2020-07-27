//
//  CubeAppInfoViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeAppInfoViewController.h"
#import "CubeAppInfoUtil.h"
#import "CubeHeader.h"
#import <CoreTelephony/CTCellularData.h>
#import "CubeAppInfoTableViewCell.h"

@interface CubeAppInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CTCellularData *cellularData;
@property (nonatomic, copy) NSString *authority;

@end

@implementation CubeAppInfoViewController

- (void)loadView
{
    [super loadView];
    
    [self initUI];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _cellularData.cellularDataRestrictionDidUpdateNotifier = nil;
    _cellularData = nil;
}

- (void)initUI
{
    self.title =@"App基本信息";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0.;
    self.tableView.estimatedSectionFooterHeight = 0.;
    self.tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:self.tableView];
}

- (void)initData
{
    // 获取设备名称
    NSString *iphoneName = [CubeAppInfoUtil iphoneName];
    // 获取当前系统版本号
    NSString *iphoneSystemVersion = [CubeAppInfoUtil iphoneSystemVersion];
    
    //获取手机型号
    NSString *deviceName = [CubeAppInfoUtil deviceName];
    
    //获取bundle id
    NSString *bundleIdentifier = [CubeAppInfoUtil bundleIdentifier];
    
    //获取App版本号
    NSString *bundleVersion = [CubeAppInfoUtil bundleVersion];
    
    //获取App版本Code
    NSString *bundleShortVersionString = [CubeAppInfoUtil bundleShortVersionString];
    
    //获取手机是否有地理位置权限
    NSString *locationAuthority = [CubeAppInfoUtil locationAuthorization];
    
    //获取网络权限
    _cellularData = [[CTCellularData alloc]init];
    __weak typeof(self) weakSelf = self;
    _cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        if (state == kCTCellularDataRestricted) {
            weakSelf.authority = @"Restricted";
        }else if(state == kCTCellularDataNotRestricted){
            weakSelf.authority = @"NotRestricted";
        }else{
            weakSelf.authority = @"Unknown";
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    };
    
    //获取push权限
    NSString *pushAuthority = [CubeAppInfoUtil pushAuthorization];
    
    //获取拍照权限
    NSString *cameraAuthority = [CubeAppInfoUtil cameraAuthorization];
    
    //获取麦克风权限
    NSString *audioAuthority = [CubeAppInfoUtil audioAuthorization];
    
    //获取相册权限
    NSString *photoAuthority = [CubeAppInfoUtil photoAuthorization];
    
    //获取通讯录权限
    NSString *addressAuthority = [CubeAppInfoUtil addressAuthorization];
    
    //获取日历权限
    NSString *calendarAuthority = [CubeAppInfoUtil calendarAuthorization];
    
    //获取提醒事项权限
    NSString *remindAuthority = [CubeAppInfoUtil remindAuthorization];
    
    NSArray *dataArray = @[
                           @{
                               @"title":(@"手机信息"),
                               @"array":@[
                                       @{
                                           @"title":@"设备名称",
                                           @"value":iphoneName
                                           },
                                       @{
                                           @"title":@"手机型号",
                                           @"value":deviceName
                                           },
                                       @{
                                           @"title":@"系统版本",
                                           @"value":iphoneSystemVersion
                                           }
                                       ]
                               },
                           @{
                               @"title":@"App信息",
                               @"array":@[@{
                                              @"title":@"Bundle ID",
                                              @"value":bundleIdentifier
                                              },
                                          @{
                                              @"title":@"Version",
                                              @"value":bundleVersion
                                              },
                                          @{
                                              @"title":@"VersionCode",
                                              @"value":bundleShortVersionString
                                              }
                                          ]
                               },
                           @{
                               @"title":@"权限信息",
                               @"array":@[@{
                                              @"title":@"地理位置权限",
                                              @"value":locationAuthority
                                              },
                                          @{
                                              @"title":@"网络权限",
                                              @"value":@"Unknown"
                                              },
                                          @{
                                              @"title":@"推送权限",
                                              @"value":pushAuthority
                                              },
                                          @{
                                              @"title":@"相机权限",
                                              @"value":cameraAuthority
                                              },
                                          @{
                                              @"title":@"麦克风权限",
                                              @"value":audioAuthority
                                              },
                                          @{
                                              @"title":@"相册权限",
                                              @"value":photoAuthority
                                              },
                                          @{
                                              @"title":@"通讯录权限",
                                              @"value":addressAuthority
                                              },
                                          @{
                                              @"title":@"日历权限",
                                              @"value":calendarAuthority
                                              },
                                          @{
                                              @"title":@"提醒事项权限",
                                              @"value":remindAuthority
                                              }
                                          ]
                               }
                           ];
    _dataArray = dataArray;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataArray[section][@"array"];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CubeAppInfoTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.cube_width, 60)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kCubeScreenWidth - 15, 60)];
    NSDictionary *dic = _dataArray[section];
    titleLabel.text = dic[@"title"];
    titleLabel.font = [UIFont cube_font14];
    titleLabel.textColor = [UIColor cube_colorBlack9];
    [sectionView addSubview:titleLabel];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"httpcell";
    CubeAppInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[CubeAppInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSArray *array = _dataArray[indexPath.section][@"array"];
    NSDictionary *item = array[indexPath.row];
    if (indexPath.section == 2 && indexPath.row == 1 && self.authority) {
        NSMutableDictionary *tempItem = [item mutableCopy];
        [tempItem setValue:self.authority forKey:@"value"];
        [cell bindWithData:tempItem];
    }else{
        [cell bindWithData:item];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2){
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
