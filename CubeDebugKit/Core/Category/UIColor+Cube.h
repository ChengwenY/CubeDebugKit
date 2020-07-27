//
//  UIColor+Cube.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/4/29.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Cube)

+ (UIColor *)cube_colorWithRGB:(uint32_t)rgbValue;
+ (UIColor*)cube_colorWithRGBA:(uint32_t)color;

+ (UIColor *)cube_colorWithString:(NSString *)string;

+ (UIColor *)cube_colorBlack3;//333
+ (UIColor *)cube_colorBlack6;//666
+ (UIColor *)cube_colorBlack9;//999

+ (UIColor *)cube_bgColor;


@end

NS_ASSUME_NONNULL_END
