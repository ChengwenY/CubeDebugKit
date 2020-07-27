//
//  CubeCrashSignalHandler.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/7/11.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeCrashSignalHandler.h"
#import <execinfo.h>
#import "CubeCrashUtil.h"

typedef void (*SignalHandler)(int signal, siginfo_t *info, void *context);

static SignalHandler previousHUPSignalHandler = NULL;
static SignalHandler previousINTSignalHandler = NULL;
static SignalHandler previousABRTSignalHandler = NULL;
static SignalHandler previousILLSignalHandler = NULL;
static SignalHandler previousSEGVSignalHandler = NULL;
static SignalHandler previousFPESignalHandler = NULL;
static SignalHandler previousBUSSignalHandler = NULL;
static SignalHandler previousPIPESignalHandler = NULL;
static SignalHandler previousTRAPSignalHandler = NULL;

@implementation CubeCrashSignalHandler

+ (void)registerHandler {
    
    [self backupOriginalHandler];
    [self registerSignal];
}

+ (void)backupOriginalHandler {
    struct sigaction old_action_hup;
    sigaction(SIGHUP, NULL, &old_action_hup);
    if (old_action_hup.sa_sigaction) {
        previousHUPSignalHandler = old_action_hup.sa_sigaction;
    }
    
    struct sigaction old_action_int;
    sigaction(SIGINT, NULL, &old_action_int);
    if (old_action_int.sa_sigaction) {
        previousINTSignalHandler = old_action_int.sa_sigaction;
    }
    
    struct sigaction old_action_abrt;
    sigaction(SIGABRT, NULL, &old_action_abrt);
    if (old_action_abrt.sa_sigaction) {
        previousABRTSignalHandler = old_action_abrt.sa_sigaction;
    }
    
    struct sigaction old_action_ill;
    sigaction(SIGILL, NULL, &old_action_ill);
    if (old_action_ill.sa_sigaction) {
        previousILLSignalHandler = old_action_ill.sa_sigaction;
    }
    
    struct sigaction old_action_segv;
    sigaction(SIGSEGV, NULL, &old_action_segv);
    if (old_action_segv.sa_sigaction) {
        previousSEGVSignalHandler = old_action_segv.sa_sigaction;
    }
    
    struct sigaction old_action_fpe;
    sigaction(SIGFPE, NULL, &old_action_fpe);
    if (old_action_fpe.sa_sigaction) {
        previousFPESignalHandler = old_action_fpe.sa_sigaction;
    }
    
    struct sigaction old_action_bus;
    sigaction(SIGBUS, NULL, &old_action_bus);
    if (old_action_bus.sa_sigaction) {
        previousBUSSignalHandler = old_action_bus.sa_sigaction;
    }
    
    struct sigaction old_action_pipe;
    sigaction(SIGPIPE, NULL, &old_action_pipe);
    if (old_action_pipe.sa_sigaction) {
        previousPIPESignalHandler = old_action_pipe.sa_sigaction;
    }
    
    struct sigaction old_action_trap;
    sigaction(SIGTRAP, NULL, &old_action_trap);
    if (old_action_trap.sa_sigaction) {
        previousTRAPSignalHandler = old_action_trap.sa_sigaction;
    }
    
}

+ (void)registerSignal {
    
    CubeSignalRegister(SIGHUP);
    CubeSignalRegister(SIGINT);
    CubeSignalRegister(SIGABRT);
    CubeSignalRegister(SIGILL);
    CubeSignalRegister(SIGSEGV);
    CubeSignalRegister(SIGFPE);
    CubeSignalRegister(SIGBUS); // 访问对象未初始化
    CubeSignalRegister(SIGPIPE); // 访问的东西已经被回收
    CubeSignalRegister(SIGTRAP);
}

static void CubeSignalRegister(int signal) {
    struct sigaction action;
    action.sa_sigaction = signalExceptionHander;
    action.sa_flags = SA_NODEFER | SA_SIGINFO;
    sigemptyset(&action.sa_mask);
    sigaction(signal, &action, 0);
}
// Signal Exception name:
// Signal Exception Codes
// Signal exception Note:
// Triggered by Thread
// Exception Backtrace:
void signalExceptionHander(int signal, siginfo_t *info, void *context) {
    
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Signal Exception:\n"];
    [mstr appendString:[NSString stringWithFormat:@"Signal Name: %@\n", signalName(signal)]];
    [mstr appendString:[NSString stringWithFormat:@"Signal Code: %d\n", info->si_code]];
    [mstr appendString:@"Exception BackTrace:\n"];
    
    // 这里过滤掉第一行日志
    // 因为注册了信号崩溃回调方法，系统会来调用，将记录在调用堆栈上，因此此行日志需要过滤掉
    for (NSUInteger index = 1; index < NSThread.callStackSymbols.count; index++) {
        NSString *str = [NSThread.callStackSymbols objectAtIndex:index];
        [mstr appendString:[str stringByAppendingString:@"\n"]];
    }
    
    [mstr appendString:@"Triggered by Thread:\n"];
    [mstr appendString:[[NSThread currentThread] description]];
    
    [CubeCrashUtil saveExceptionLog:mstr fileName:@"Crash(Signal)"];
    
    CubeClearSignalRigister();
    
    previousSignalHandler(signal, info, context);
    kill(getpid(), SIGKILL);
}

#pragma mark - SignalName
static NSString *signalName(int signal) {
    NSString *signalName;
    switch (signal) {
        case SIGHUP:
            signalName = @"SIGHUP";
            break;
        case SIGINT:
            signalName = @"SIGINT";
            break;
        case SIGABRT:
            signalName = @"SIGABRT";
            break;
        case SIGBUS:
            signalName = @"SIGBUS";
            break;
        case SIGFPE:
            signalName = @"SIGFPE";
            break;
        case SIGILL:
            signalName = @"SIGILL";
            break;
        case SIGPIPE:
            signalName = @"SIGPIPE";
            break;
        case SIGSEGV:
            signalName = @"SIGSEGV";
            break;
        case SIGTRAP:
            signalName = @"SIGTRAP";
            break;
        default:
            break;
    }
    return signalName;
}

#pragma mark Previous Signal

static void previousSignalHandler(int signal, siginfo_t *info, void *context) {
    SignalHandler previousSignalHandler = NULL;
    switch (signal) {
        case SIGHUP:
            previousSignalHandler = previousHUPSignalHandler;
            break;
        case SIGINT:
            previousSignalHandler = previousINTSignalHandler;
            break;
        case SIGABRT:
            previousSignalHandler = previousABRTSignalHandler;
            break;
        case SIGBUS:
            previousSignalHandler = previousBUSSignalHandler;
            break;
        case SIGFPE:
            previousSignalHandler = previousFPESignalHandler;
            break;
        case SIGILL:
            previousSignalHandler = previousILLSignalHandler;
            break;
        case SIGPIPE:
            previousSignalHandler = previousPIPESignalHandler;
            break;
        case SIGSEGV:
            previousSignalHandler = previousSEGVSignalHandler;
            break;
        case SIGTRAP:
            previousSignalHandler = previousTRAPSignalHandler;
            break;
        default:
            break;
    }
    
    if (previousSignalHandler) {
        previousSignalHandler(signal, info, context);
    }
}

#pragma mark Clear

static void CubeClearSignalRigister() {
    
    signal(SIGINT, SIG_DFL);
    signal(SIGHUP, SIG_DFL);
    signal(SIGSEGV,SIG_DFL);
    signal(SIGFPE,SIG_DFL);
    signal(SIGBUS,SIG_DFL);
    signal(SIGTRAP,SIG_DFL);
    signal(SIGABRT,SIG_DFL);
    signal(SIGILL,SIG_DFL);
    signal(SIGPIPE,SIG_DFL);
    
}

@end
