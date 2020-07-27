//
//  CubeHomeViewController.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeHomeViewController.h"
#import "CubeHeader.h"
#import "CubePluginDataSource.h"
#import "CubeHomeCollectionViewCell.h"
#import "CubePluginTypeModel.h"
#import "CubeHomeSectionHeaderView.h"
#import "CubePluginProtocol.h"

static NSString * const cubeHomeCellIdentifier = @"cube_homeCellIdentifier";
static NSString * const cubeHomeSectionHeaderIdentifier = @"cube_sectionHeaderIdentifier";

@interface CubeHomeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CubeHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"DEBUG";
    [self initCollectionView];
    self.view.backgroundColor = [UIColor cube_bgColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = (kCubeScreenWidth - 20)/4;
    flowLayout.itemSize = CGSizeMake(width, 80);
    flowLayout.headerReferenceSize = CGSizeMake(self.view.cube_width, 60);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.cube_width, self.view.cube_height) collectionViewLayout:flowLayout];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CubeHomeCollectionViewCell class] forCellWithReuseIdentifier:cubeHomeCellIdentifier];
    [self.collectionView registerClass:[CubeHomeSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cubeHomeSectionHeaderIdentifier];
    [self.view addSubview:self.collectionView];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CubeHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cubeHomeCellIdentifier forIndexPath:indexPath];
    
    CubePluginTypeModel *model = [[CubePluginDataSource sharedInstance] dataSource][indexPath.section][indexPath.item];
    
    [cell bindWithPluginTypeModel:model atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *items = [[CubePluginDataSource sharedInstance] dataSource][section];
    return items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ECubePluginSectionCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CubeHomeSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cubeHomeSectionHeaderIdentifier forIndexPath:indexPath];
        
        NSString *headerTitle = [[CubePluginDataSource sharedInstance] titleForPluginSection:indexPath.section];
        [header bindWithTitle:headerTitle];
        
        return header;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CubePluginTypeModel *model = [[CubePluginDataSource sharedInstance] dataSource][indexPath.section][indexPath.row];
    
    if (model)
    {
        Class pluginClass = NSClassFromString(model.pluginName);
        
        id<CubePluginProtocol> plugin = [[pluginClass alloc] init];
        
        if ([plugin respondsToSelector:@selector(loadPlugin)])
        {
            [plugin loadPlugin];
        }
        if ([plugin respondsToSelector:@selector(loadPlugin:)])
        {
            [plugin loadPlugin:@{}];
        }
    }
}

@end
