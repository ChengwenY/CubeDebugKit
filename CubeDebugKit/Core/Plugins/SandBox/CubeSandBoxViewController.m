//
//  CubeSandBoxViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeSandBoxViewController.h"
#import "CubeHeader.h"
#import "CubeAppInfoUtil.h"
#import "CubeSandBoxModel.h"
#import "CubeSandBoxTableViewCell.h"
#import "CubeFileUtil.h"
#import "CubeSandBoxDetailViewController.h"

@interface CubeSandBoxViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CubeSandBoxViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.path = NSHomeDirectory();
    }
    
    return self;
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self)
    {
        self.title = [path lastPathComponent];
        self.path = path;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"沙盒浏览器";
    [self initUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)loadData
{
    [self.dataSource removeAllObjects];
    NSArray *paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
    for (NSString *path in paths) {
        
        CubeSandBoxModel *model = [[CubeSandBoxModel alloc] init];
        NSString *currentPath = [self.path stringByAppendingPathComponent:path];
        BOOL isDir = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:currentPath isDirectory:&isDir];
        if (isExist)
        {
            if (isDir) {
                model.type = ECubeSandBoxFileTypeDirectory;
            }
            else
            {
                NSString *ext = [currentPath pathExtension];
                if ([ext isEqualToString:@"DB"] || [ext isEqualToString:@"db"] || [ext isEqualToString:@"sqlite"] || [ext isEqualToString:@"SQLITE"])
                {
                    model.type = ECubeSandBoxFileTypeDB;
                }
                else if ([ext isEqualToString:@"png"]  || [ext isEqualToString:@"PNG"]
                         || [ext isEqualToString:@"jpg"]  || [ext isEqualToString:@"JPG"]
                         || [ext isEqualToString:@"jpeg"] || [ext isEqualToString:@"JPEG"]
                         || [ext isEqualToString:@"gif"]  || [ext isEqualToString:@"GIF"])
                {
                    model.type = ECubeSandBoxFileTypeImage;
                }
                else if ([ext isEqualToString:@"strings"] || [ext isEqualToString:@"plist"]
                         || [ext isEqualToString:@"txt"] || [ext isEqualToString:@"log"]
                         || [ext isEqualToString:@"csv"])
                {
                    model.type = ECubeSandBoxFileTypeText;
                }
                else if ([ext isEqualToString:@"mp4"] || [ext isEqualToString:@"MP4"]
                         || [ext isEqualToString:@"mov"] || [ext isEqualToString:@"MOV"]
                         || [ext isEqualToString:@"mp3"] || [ext isEqualToString:@"MP3"]
                         || [ext isEqualToString:@"wav"] || [ext isEqualToString:@"WAV"])
                {
                    model.type = ECubeSandBoxFileTypeAV;
                }
                else
                {
                    model.type = ECubeSandBoxFileTypeFile;
                }
            }
            model.name = [path lastPathComponent];
            model.path = currentPath;
            model.size = [CubeFileUtil formatteredSizeAtFilePath:currentPath];
            [self.dataSource addObject:model];
        }
    }
    
    [self.tableView reloadData];
}

- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identi = @"identi";
    CubeSandBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[CubeSandBoxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    
    CubeSandBoxModel *model = self.dataSource[indexPath.row];
    [cell bindWithData:model];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    CubeSandBoxModel *model = self.dataSource[indexPath.row];
    [self deleteByDoraemonSandboxModel:model];
}


#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CubeSandBoxTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CubeSandBoxModel *model = self.dataSource[indexPath.row];
    if(model.type == ECubeSandBoxFileTypeDirectory){

        CubeSandBoxViewController *vc = [[CubeSandBoxViewController alloc] initWithPath:model.path];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        CubeSandBoxDetailViewController *vc = [[CubeSandBoxDetailViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)deleteByDoraemonSandboxModel:(CubeSandBoxModel *)model{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:model.path error:nil];
    [self loadData];
}

@end
