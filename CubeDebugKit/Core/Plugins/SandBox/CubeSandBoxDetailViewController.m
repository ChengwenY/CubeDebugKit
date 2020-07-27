//
//  CubeSandBoxDetailViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeSandBoxDetailViewController.h"
#import "CubeHeader.h"
#import "CubeSandBoxModel.h"
#import "CubeSandBoxView.h"
#import <AVKit/AVPlayerViewController.h>
#import <QuickLook/QLPreviewController.h>
#import "CubeDBManager.h"
#import "CubeDBTableViewController.h"

@interface CubeSandBoxDetailViewController ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CubeSandBoxModel *model;
@property (nonatomic, strong) AVPlayerViewController *avPlayer;
@property (nonatomic, strong) UITableView *dbTableNameTableView;
@property (nonatomic, strong) NSMutableArray *tableNameArray;

@end

@implementation CubeSandBoxDetailViewController

- (instancetype)initWithModel:(CubeSandBoxModel *)model
{
    if (self = [super init])
    {
        self.model = model;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.title = [self.model.path lastPathComponent];
    [self createShareBtn];
    [self initUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSMutableArray *)tableNameArray
{
    if (!_tableNameArray)
    {
        _tableNameArray = @[].mutableCopy;
    }
    return _tableNameArray;
}

- (void)createShareBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage cube_imageNamed:@"cube-share"] forState:UIControlStateNormal];
    [btn.widthAnchor constraintEqualToConstant:40].active = YES;
    [btn.heightAnchor constraintEqualToConstant:44].active = YES;
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -(40-image.size.width)/2, 0, 0);
    [btn addTarget:self action:@selector(shareFile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)shareFile
{
    NSURL *url = [NSURL fileURLWithPath:self.model.path];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)initUI
{
    switch (_model.type) {
        case ECubeSandBoxFileTypeImage:
            [self setImageView];
            break;
        case ECubeSandBoxFileTypeAV:
            [self setAVFile];
            break;
        case ECubeSandBoxFileTypeText:
            [self setTextView];
            break;
        case ECubeSandBoxFileTypeDB:
            [self setDBFile];
            break;
        case ECubeSandBoxFileTypeFile:
            [self setFilePreview];
            break;
        default:
            break;
    }
}

- (void)setImageView
{
    CubeSandBoxImageView *imgView = [[CubeSandBoxImageView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT)];
    [imgView setFilePath:self.model.path];
    
    [self.view addSubview:imgView];
}

- (void)setTextView
{
    CubeSandBoxTextView *textView = [[CubeSandBoxTextView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT)];
    [textView setFilePath:self.model.path];
    [self.view addSubview:textView];
}

- (void)setAVFile {
    self.avPlayer = [[AVPlayerViewController alloc] init];
    NSURL *sourceMediaURL = [NSURL fileURLWithPath:self.model.path];
    AVAsset *mediaAsset = [AVURLAsset URLAssetWithURL:sourceMediaURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:mediaAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    self.avPlayer.player = player;
    self.avPlayer.showsPlaybackControls = YES;
    [self.avPlayer.player play];
    [self addChildViewController:self.avPlayer];
    [self.view addSubview:self.avPlayer.view];
    self.avPlayer.view.frame = CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT);
}

- (void)setDBFile
{
    [CubeDBManager sharedInstance].dbPath = self.model.path;
    self.tableNameArray = [[CubeDBManager sharedInstance] tablesAtDB].mutableCopy;
    self.dbTableNameTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.cube_width, self.view.cube_height) style:UITableViewStylePlain];
    self.dbTableNameTableView.backgroundColor = [UIColor whiteColor];
    self.dbTableNameTableView.delegate = self;
    self.dbTableNameTableView.dataSource = self;
    [self.view addSubview:self.dbTableNameTableView];
}

- (void)setFilePreview
{
    QLPreviewController *preVC = [[QLPreviewController alloc]init];
    preVC.delegate =self;
    preVC.dataSource =self;
    [preVC setCurrentPreviewItemIndex:0];
    [self presentViewController:preVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = self.tableNameArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* tableName = [self.tableNameArray objectAtIndex:indexPath.row];
    [CubeDBManager sharedInstance].tableName = tableName;
    
    CubeDBTableViewController *vc = [[CubeDBTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return [NSURL fileURLWithPath:self.model.path];
    
}
@end
