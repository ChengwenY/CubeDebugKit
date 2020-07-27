//
//  CubeDebugKitDefine.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/4/29.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#ifndef CubeDebugKitDefine_h
#define CubeDebugKitDefine_h

#define kCubeScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCubeScreenHeight [UIScreen mainScreen].bounds.size.height

#define kCubeIOS9_OR_LATER [[[UIDevice currentDevice].systemVersion] doubleValue] - 9.0 >= DBL_EPSILON ? YES : NO

#define IS_IPHONE_X_Series [CubeDebugKitUtil isIphoneXSeries]
#define IPHONE_NAVIGATIONBAR_HEIGHT  (IS_IPHONE_X_Series ? 88 : 64)
#define IPHONE_STATUSBAR_HEIGHT      (IS_IPHONE_X_Series ? 44 : 20)
#define IPHONE_SAFEBOTTOMAREA_HEIGHT (IS_IPHONE_X_Series ? 34 : 0)
#define IPHONE_TOPSENSOR_HEIGHT      (IS_IPHONE_X_Series ? 32 : 0)

#endif /* CubeDebugKitDefine_h */
