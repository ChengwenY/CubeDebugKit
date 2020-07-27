//
//  UIColor+Cube.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/4/29.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "UIColor+Cube.h"

@implementation UIColor (Cube)

+ (UIColor *)cube_colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor*)cube_colorWithRGBA:(uint32_t)color
{
    return [UIColor colorWithRed:((color>>24)&0xFF)/255.0
                           green:((color>>16)&0xFF)/255.0
                            blue:((color>>8)&0xFF)/255.0
                           alpha:((color)&0xFF)/255.0];
}

+ (UIColor *)cube_colorWithString:(NSString *)string
{
    NSInteger c = 0;
    sscanf([string UTF8String], "%llu", (unsigned long long *)&c);
    return [UIColor cube_colorWithRGBA:c];
}

+ (UIColor *)cube_colorBlack3
{
    return [UIColor cube_colorWithRGB:0x333333];
}

+ (UIColor *)cube_colorBlack6
{
    return [UIColor cube_colorWithRGB:0x666666];
}

+ (UIColor *)cube_colorBlack9
{
    return [UIColor cube_colorWithRGB:0x999999];
}

+ (UIColor *)cube_bgColor
{
    return [UIColor cube_colorWithRGB:0xeaeaea];
}
@end
