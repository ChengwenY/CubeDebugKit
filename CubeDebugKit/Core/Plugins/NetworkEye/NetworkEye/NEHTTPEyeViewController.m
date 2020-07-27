//
//  NEHTTPEyeViewController.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPEyeViewController.h"

#import "NEHTTPModel.h"
#import "NEHTTPModelManager.h"
#import "NEHTTPEyeDetailViewController.h"
#import "NEHTTPEyeSettingsViewController.h"
#import "UIFont+Cube.h"

@interface NEHTTPEyeViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate> {
    UITableView *mainTableView;
    NSArray *httpRequests;
    UISearchBar *mySearchBar;
    UISearchController *searchController;
    NSArray *filterHTTPRequests;
    UILabel *titleTextLabel;
    NSInteger currentRequestCount;
    
    BOOL isSearching;
    NSString *searchText;
}

@end

@implementation NEHTTPEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainTableView];
    
    double flowCount=[[[NSUserDefaults standardUserDefaults] objectForKey:@"flowCount"] doubleValue];
    if (!flowCount) {
        flowCount=0.0;
    }
    UIColor *titleColor=[UIColor blackColor];
    UIFont *titleFont=[UIFont systemFontOfSize:18.0];
    UIColor *detailColor=[UIColor blackColor];
    UIFont *detailFont=[UIFont systemFontOfSize:12.0];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"NetworkEye\n"
                                                                                    attributes:@{
                                                                                                 NSFontAttributeName : titleFont,
                                                                                                 NSForegroundColorAttributeName: titleColor
                                                                                                 }];
    
    NSMutableAttributedString *flowCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"流量共%.1lfMB",flowCount]
                                                                                        attributes:@{
                                                                                                     NSFontAttributeName : detailFont,
                                                                                                     NSForegroundColorAttributeName: detailColor
                                                                                                     }];
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];
    [attrText appendAttributedString:titleString];
    [attrText appendAttributedString:flowCountString];
    titleTextLabel = [[UILabel alloc] initWithFrame: CGRectMake(([[UIScreen mainScreen] bounds].size.width-120)/2, 20, 120, 44)];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    titleTextLabel.textColor=[UIColor whiteColor];
    titleTextLabel.textAlignment=NSTextAlignmentCenter;
    titleTextLabel.numberOfLines=0;
    titleTextLabel.attributedText=attrText;
    
    if ([self.navigationController viewControllers].count<1) {
        UINavigationBar *bar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
        [self.view addSubview:bar];
        bar.barTintColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
        
        UIButton *settingsBt=[UIButton buttonWithType:UIButtonTypeCustom];
        settingsBt.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-60, 27, 50, 30);
        [settingsBt setTitle:@"设置" forState:UIControlStateNormal];
        settingsBt.titleLabel.font=[UIFont systemFontOfSize:13];
        [settingsBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settingsBt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:settingsBt];
        mainTableView.frame=CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
        [bar addSubview:titleTextLabel];
    }else{
        titleTextLabel.frame=CGRectMake(([[UIScreen mainScreen] bounds].size.width-120)/2, 0, 120, 44);
        [self.navigationController.navigationBar addSubview:titleTextLabel];
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        self.navigationItem.rightBarButtonItem=right;
    }

    [self setupSearch];
    mainTableView.dataSource=self;
    mainTableView.delegate=self;
    
    httpRequests=[[NEHTTPModelManager defaultManager] allobjects];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    httpRequests=[[NEHTTPModelManager defaultManager] allobjects];
    filterHTTPRequests = httpRequests;
    currentRequestCount = httpRequests.count;
    [mainTableView reloadData];
    titleTextLabel.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (currentRequestCount > 0)
    {
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self->mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->currentRequestCount - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    titleTextLabel.hidden = YES;
}

- (void)rightAction {
    NEHTTPEyeSettingsViewController *settings = [[NEHTTPEyeSettingsViewController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}

- (void)setupSearch {
    
    filterHTTPRequests = httpRequests;
    
//    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.dimsBackgroundDuringPresentation = NO;
    mainTableView.tableHeaderView = searchController.searchBar;
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    searchController.active = NO;
}
- (void)backBtAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - UITableViewDataSource  &UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == mySearchDisplayController.searchResultsTableView) {
//        return filterHTTPRequests.count;
//    }
    if (isSearching)
    {
        return filterHTTPRequests.count;
    }
    return httpRequests.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    NSString *cellId=@"CellId";
    cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
    }
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.textColor=[UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f];
    NEHTTPModel *currenModel=[self modelForTableView:tableView atIndexPath:indexPath];
    
    cell.textLabel.text=currenModel.requestURLString;

    NSAttributedString *responseStatusCode;
    NSAttributedString *requestHTTPMethod;
    UIColor *titleColor=[UIColor colorWithRed:0.96 green:0.15 blue:0.11 alpha:1];
    if (currenModel.responseStatusCode == 200) {
        titleColor=[UIColor colorWithRed:0.11 green:0.76 blue:0.13 alpha:1];
    }
    UIFont *titleFont=[UIFont systemFontOfSize:12.0];
    UIColor *detailColor=[UIColor blackColor];
    UIFont *detailFont=[UIFont systemFontOfSize:12.0];
    responseStatusCode = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d   ",currenModel.responseStatusCode]
                                                             attributes:@{
                                                                          NSFontAttributeName : titleFont,
                                                                          NSForegroundColorAttributeName: titleColor
                                                                          }];
    
    requestHTTPMethod = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   %@   %@",currenModel.requestHTTPMethod,currenModel.responseMIMEType,[((NEHTTPModel *)((httpRequests)[indexPath.row])).startDateString substringFromIndex:5]]
                                                           attributes:@{
                                                                        NSFontAttributeName : detailFont,
                                                                        NSForegroundColorAttributeName: detailColor
                                                                        }];
    NSMutableAttributedString *detail=[[NSMutableAttributedString alloc] init];
    [detail appendAttributedString:responseStatusCode];
    [detail appendAttributedString:requestHTTPMethod];
    cell.detailTextLabel.attributedText=detail;
//    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    searchController.active = NO;
    
    NEHTTPEyeDetailViewController *detail = [[NEHTTPEyeDetailViewController alloc] init];
    detail.model = [self modelForTableView:tableView atIndexPath:indexPath];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)updateSearchResultsWithSearchString:(NSString *)searchString {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *tempFilterHTTPRequests = [self->httpRequests filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NEHTTPModel *httpRequest, NSDictionary *bindings) {
            return [[NSString stringWithFormat:@"%@ %d %@ %@",httpRequest.requestURLString,httpRequest.responseStatusCode,httpRequest.requestHTTPMethod,httpRequest.responseMIMEType] rangeOfString:searchString options:NSCaseInsensitiveSearch].length > 0;
        }]];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            self->filterHTTPRequests = searchString.length == 0 ? self->httpRequests : tempFilterHTTPRequests;
            [self->mainTableView reloadData];
        });
    });
}

#pragma mark - UISearchControllerDelegate

- (void)didPresentSearchController:(UISearchController *)searchController
{
    isSearching = YES;
    [mainTableView reloadData];
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    isSearching = NO;
    [mainTableView reloadData];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    searchText = searchController.searchBar.text;
    [self updateSearchResultsWithSearchString:searchController.searchBar.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (NEHTTPModel *)modelForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NEHTTPModel *currenModel=[[NEHTTPModel alloc] init];
    if (isSearching)
    {
        currenModel=(NEHTTPModel *)((filterHTTPRequests)[indexPath.row]);
    } else {
        currenModel=(NEHTTPModel *)((httpRequests)[indexPath.row]);
    }
    return currenModel;
}

@end
