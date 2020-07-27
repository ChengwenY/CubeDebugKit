//
//  MemoryMonitorView.m
//  HaloSlim
//
//  Created by Chengwen.Y on 16/9/8.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "CubeEntryView.h"
#import "CubeHeader.h"
#import "CubeStatusBarViewController.h"
#import "CubeHomeWindow.h"

#define kDefaultAlpha 0.7

@interface CubeEntryView ()

@property (nonatomic, assign) CGPoint beganPoint;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIButton *entryBtn;
@property (nonatomic, assign) BOOL showingDebug;

@end

@implementation CubeEntryView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, kCubeScreenHeight/3, 40, 40)];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 100.f;
        
        self.backgroundColor = [UIColor colorWithRed:0.662 green:0.437 blue:1.000 alpha:1.000];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 20;
        
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (!self.rootViewController)
        {
            if (version.doubleValue >= 10.0)
            {
                self.rootViewController = [[UIViewController alloc] init];
            }
            else
            {
                self.rootViewController = [[CubeStatusBarViewController alloc] init];
            }
        }
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        self.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width/2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        [tap requireGestureRecognizerToFail:pan];
    }
    
    return self;
}

- (void)becomeKeyWindow
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    [appWindow makeKeyAndVisible];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint convertPoint = [self convertPoint:point toWindow:[UIApplication sharedApplication].keyWindow];

    if ([self.path containsPoint:convertPoint])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint offsetPoint = [sender translationInView:sender.view];
    
    [sender setTranslation:CGPointZero inView:sender.view];
    UIView *panView = sender.view;
    
    CGFloat newX = panView.cube_centerX + offsetPoint.x;
    CGFloat newY = panView.cube_centerY + offsetPoint.y;
    
    
    if (newX < self.bounds.size.width/2)
    {
        newX = self.bounds.size.width/2;
    }
    else if (newX > kCubeScreenWidth - self.bounds.size.width/2)
    {
        newX = kCubeScreenWidth - self.bounds.size.width/2;
    }

    if (newY < self.bounds.size.height/2)
    {
        newY = self.bounds.size.height/2;
    }
    else if (newY > kCubeScreenHeight - self.bounds.size.height/2)
    {
        newY = kCubeScreenHeight - self.bounds.size.height/2;
    }
    
    panView.center = CGPointMake(newX, newY);
    self.path = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width/2 startAngle:0 endAngle:2 * M_PI clockwise:YES];

}

- (void)tap:(UITapGestureRecognizer *)sender
{
    if (self.showingDebug)
    {
        [[CubeHomeWindow sharedInstance] hide];
    }
    else
    {
        [[CubeHomeWindow sharedInstance] show];
    }
    self.showingDebug = !self.showingDebug;
}

@end
