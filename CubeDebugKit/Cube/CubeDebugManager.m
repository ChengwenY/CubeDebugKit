//
//  HaloMemoryMonitorManager.m
//  HaloSlim
//
//  Created by Chengwen.Y on 16/9/18.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "CubeDebugManager.h"
#import "CubeEntryView.h"
#import "CubeHomeViewController.h"
#import "CubeHomeWindow.h"
#import "NEHTTPEye.h"
#import "CubeCrashSignalHandler.h"
#import "CubeCrashUncaughtExceptionHandler.h"

@interface CubeDebugManager ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSByteCountFormatter *formatter;
@property (nonatomic, strong) CubeEntryView *entryView;
@end

@implementation CubeDebugManager

+ (instancetype)sharedInstance
{
    static CubeDebugManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.formatter = [[NSByteCountFormatter alloc] init];
    }
    
    return self;
}

- (void)install
{
    [NEHTTPEye setEnabled:YES];

    [CubeCrashSignalHandler registerHandler];
    [CubeCrashUncaughtExceptionHandler registerHandler];
}

- (void)initEntryView
{
    self.entryView = [[CubeEntryView alloc] init];
    [self.entryView makeKeyAndVisible];
}

@end
