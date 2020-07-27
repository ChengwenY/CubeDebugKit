//
//  CubeHomeWindow.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeHomeWindow.h"
#import "CubeHomeViewController.h"
#import "CubeHeader.h"

@interface CubeHomeWindow ()

@property (nonatomic, strong) UINavigationController *nav;

@end

@implementation CubeHomeWindow

+ (instancetype)sharedInstance
{
    static CubeHomeWindow *sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[CubeHomeWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    return sharedObj;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.hidden = YES;
    }
    return self;
}

- (void)showPlugin:(UIViewController *)vc
{
    if (self.nav)
    {
        [self.nav pushViewController:vc animated:YES];
    }
    else
    {
        [self setRootVC:vc];
    }

}

- (void)show
{
    CubeHomeViewController *vc = [[CubeHomeViewController alloc] init];
    
    [self setRootVC:vc];
    
    self.hidden = NO;
}

- (void)hide
{
    self.rootViewController = nil;
    self.nav = nil;
    self.hidden = YES;
}

- (void)setRootVC:(UIViewController *)vc
{
    self.nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                 NSFontAttributeName: [UIFont cube_font18],
                                 };
    [self.nav.navigationBar setTitleTextAttributes:attributes];
    self.rootViewController = self.nav;
}


@end
