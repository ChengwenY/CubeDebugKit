//
//  CubeCrashListViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/7/12.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeCrashListViewController.h"
#import "CubeHeader.h"
#import "CubeCrashUtil.h"
#import "CubeSandBoxDetailViewController.h"
#import "CubeSandBoxModel.h"
#import "CubeSandBoxTableViewCell.h"

@interface CubeCrashListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CubeCrashListViewController

- (void)loadView {
    [super loadView];
 
    [self createView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCrashFile];
    self.title = @"crash 列表";
}

- (void)createView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.cube_width, self.view.cube_height - IPHONE_NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)loadCrashFile {
    
    NSString *crashDir = [CubeCrashUtil cacheDir];
    NSFileManager *fm =[NSFileManager defaultManager];
    
    if (crashDir && [fm fileExistsAtPath:crashDir]) {
        NSArray *paths = [fm contentsOfDirectoryAtPath:crashDir error:nil];
        
        NSArray *sortedPaths = [paths sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            
            NSString *firstPath = [crashDir stringByAppendingPathComponent:obj1];
            NSString *secondPath = [crashDir stringByAppendingPathComponent:obj2];
            
            NSDictionary *firstFileInfo = [fm attributesOfItemAtPath:firstPath error:nil];
            NSDictionary *secondFileInfo = [fm attributesOfItemAtPath:secondPath error:nil];
            
            NSDate *firstDate = [firstFileInfo objectForKey:NSFileCreationDate];
            NSDate *secondDate = [secondFileInfo objectForKey:NSFileCreationDate];
            return [firstDate compare:secondDate];
        }];
        
        NSMutableArray *files = [NSMutableArray array];
        
        [sortedPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSString *fullPath = [crashDir stringByAppendingPathComponent:obj];
            BOOL isDir = false;
            
            if ([fm fileExistsAtPath:fullPath isDirectory:&isDir])
            {
                CubeSandBoxModel *model = [[CubeSandBoxModel alloc] init];
                model.path = fullPath;
                if (isDir) {
                    model.type = ECubeSandBoxFileTypeDirectory;
                } else {
                    model.type = ECubeSandBoxFileTypeFile;
                }
                model.name = obj;
                [files addObject:model];
            }
        }];
        self.dataSource = files;
        [self.tableView reloadData];
    }
}

- (void)deleteCrashFile:(CubeSandBoxModel *)model
{
    NSString *path = model.path;
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    [self loadCrashFile];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CubeSandBoxTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    CubeSandBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[CubeSandBoxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell bindWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CubeSandBoxModel *model = self.dataSource[indexPath.row];
    CubeSandBoxDetailViewController *vc = [[CubeSandBoxDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCrashFile:self.dataSource[indexPath.row]];
    }
}
@end
