//
//  CubePluginDataSource.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubePluginDataSource.h"
#import "CubePluginTypeModel.h"

@implementation CubePluginDataSource

+ (instancetype)sharedInstance
{
    static CubePluginDataSource *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[CubePluginDataSource alloc] init];
    });
    
    return shared;
}

- (NSArray *)dataSource
{
    return @[
            @[
               [self pluginTitle:@"查看网络请求" icon:@"cube-network" desc:@"查看网络请求" type:ECubePluginTypeNetwork pluginName:@"CubeNetworkEyePlugin"],
            ],
            @[
               [self pluginTitle:@"APP信息" icon:@"cube-app-info" desc:@"APP信息" type:ECubePluginTypeAppInfo pluginName:@"CubeAppInfoPlugin"],
               [self pluginTitle:@"沙盒文件" icon:@"cube-sand-box" desc:@"沙盒文件" type:ECubePluginTypeSandBox pluginName:@"CubeSandBoxPlugin"],
               [self pluginTitle:@"Crash" icon:@"cube-crash" desc:@"崩溃查看" type:ECubePluginTypeCrash pluginName:@"CubeCrashPlugin"],
               [self pluginTitle:@"清除本地数据" icon:@"cube-clear" desc:@"清除本地数据" type:ECubePluginTypeClearLocalData pluginName:@"ClearLocalDataPlugin"],
            ],
            @[
                [self pluginTitle:@"FPS" icon:@"cube-fps" desc:@"帧率" type:ECubePluginTypeFps pluginName:@"CubeFpsPlugin"],
                [self pluginTitle:@"CPU" icon:@"cube-cpu" desc:@"cpu" type:ECubePluginTypeCPU pluginName:@"CubeCpuPlugin"],
                [self pluginTitle:@"内存" icon:@"cube-cpu" desc:@"内存使用" type:ECubePluginTypeMemory pluginName:@"CubeMemoryPlugin"],
                [self pluginTitle:@"卡顿检测" icon:@"cube-fps" desc:@"卡顿检测" type:ECubePluginTypeLag pluginName:@"CubeLagPlugin"],
            ],
            @[
                [self pluginTitle:@"点击显示边框" icon:@"cube-click" desc:@"" type:ECubePluginTypeClickBorder pluginName:@"CubeUIBorderPlugin"]
            ],
            ];
}

- (NSString *)titleForPluginSection:(CubePluginSection)section
{
    switch (section) {
        case ECubePluginSectionBusiness:
            return @"业务工具";
        case ECubePluginSectionCommon:
            return @"常用工具";
        case ECubePluginSectionPerformance:
            return @"性能监控";
        case ECubePluginSectionUI:
            return @"UI工具";
        default:
            return @"";
    }
}

- (CubePluginTypeModel *)pluginTitle:(NSString *)title
                                icon:(NSString *)icon
                                desc:(NSString *)desc
                                type:(CubePluginType)type
                          pluginName:(NSString *)pluginName

{
    CubePluginTypeModel *model = [[CubePluginTypeModel alloc] init];
    model.title = title;
    model.icon = icon;
    model.desc = desc;
    model.pluginType = type;
    model.pluginName = pluginName;
    return model;
}

@end
