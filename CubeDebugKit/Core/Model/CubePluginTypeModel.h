//
//  CubePluginTypeModel.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CubeTypedef.h"

NS_ASSUME_NONNULL_BEGIN

@interface CubePluginTypeModel : NSObject

@property (nonatomic, assign) CubePluginType pluginType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pluginName;

@end

NS_ASSUME_NONNULL_END
