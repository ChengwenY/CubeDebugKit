//
//  CubeCrashUncaughtExceptionHandler.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/7/11.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeCrashUncaughtExceptionHandler.h"
#import "CubeCrashUtil.h"

static NSUncaughtExceptionHandler *previousUncaughtExceptionHandler = NULL;

@implementation CubeCrashUncaughtExceptionHandler

+ (void)registerHandler {
    previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler);
}

static void UncaughtExceptionHandler(NSException *ex) {
    
    NSArray *stacks = [ex callStackSymbols];
    NSString *reason = ex.reason;
    NSString *name = ex.name;
    
    NSString *exceptionInfo = [NSString stringWithFormat:@"======UncaughtException 错误报告======\nname: %@\nreason:%@\ncallStackSymbols:\n%@\n",name, reason, [stacks componentsJoinedByString:@"\n"]];
    
    [CubeCrashUtil saveExceptionLog:exceptionInfo fileName:@"Crash(Uncaught)"];
    
    if (previousUncaughtExceptionHandler) {
        previousUncaughtExceptionHandler(ex);
    }
    
    kill(getpid(), SIGKILL);
    
}
@end
