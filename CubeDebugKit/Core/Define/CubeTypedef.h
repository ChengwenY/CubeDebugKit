//
//  CubeTypedef.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#ifndef CubeTypedef_h
#define CubeTypedef_h

typedef NS_ENUM(NSUInteger, CubePluginType) {
    
    ECubePluginTypeNetwork,
    
    ECubePluginTypeAppInfo,
    ECubePluginTypeSandBox,
    ECubePluginTypeCrash,
    ECubePluginTypeClearLocalData,
    ECubePluginTypeLog,
    
    ECubePluginTypeFps,
    ECubePluginTypeCPU,
    ECubePluginTypeMemory,
    ECubePluginTypeLag,
    ECubePluginTypeMethodTime,
    
    ECubePluginTypeBorder,
    ECubePluginTypeClickBorder,
    
};

typedef NS_ENUM(NSUInteger, CubePluginSection) {
    ECubePluginSectionBusiness = 0,
    ECubePluginSectionCommon,
    ECubePluginSectionPerformance,
    ECubePluginSectionUI,
    ECubePluginSectionCount,
};

typedef NS_ENUM(NSUInteger, CubeSandBoxFileType) {
    
    ECubeSandBoxFileTypeDirectory,
    ECubeSandBoxFileTypeImage,
    ECubeSandBoxFileTypeAV,
    ECubeSandBoxFileTypeDB,
    ECubeSandBoxFileTypeText,
    ECubeSandBoxFileTypeFile,
    
};


#endif /* CubeTypedef_h */
