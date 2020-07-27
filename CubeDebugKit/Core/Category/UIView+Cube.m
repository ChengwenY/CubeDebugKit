//
//  UIView+Cube.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "UIView+Cube.h"

@implementation UIView (Cube)

@dynamic cube_left, cube_top, cube_size, cube_right, cube_width, cube_bottom, cube_height, cube_origin, cube_centerX, cube_centerY;

- (CGFloat)cube_left {
    return self.frame.origin.x;
}

- (void)setCube_left:(CGFloat)cube_left {
    CGRect frame = self.frame;
    frame.origin.x = cube_left;
    self.frame = frame;
}

- (CGFloat)cube_top {
    return self.frame.origin.y;
}

- (void)setCube_top:(CGFloat)cube_top {
    CGRect frame = self.frame;
    frame.origin.y = cube_top;
    self.frame = frame;
}

- (CGFloat)cube_right {
    return self.frame.origin.x + self.cube_width;
}

- (void)setCube_right:(CGFloat)cube_right {
    CGRect frame = self.frame;
    frame.origin.x = cube_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)cube_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCube_bottom:(CGFloat)cube_bottom {
    CGRect frame = self.frame;
    frame.origin.y = cube_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)cube_centerX {
    return self.center.x;
}

- (void)setCube_centerX:(CGFloat)cube_centerX {
    self.center = CGPointMake(cube_centerX, self.center.y);
}

- (CGFloat)cube_centerY {
    return self.center.y;
}

- (void)setCube_centerY:(CGFloat)cube_centerY {
    self.center = CGPointMake(self.center.x, cube_centerY);
}

- (CGFloat)cube_width {
    return self.frame.size.width;
}

- (void)setCube_width:(CGFloat)cube_width {
    CGRect frame = self.frame;
    frame.size.width = cube_width;
    self.frame = frame;
}

- (CGFloat)cube_height {
    return self.frame.size.height;
}

- (void)setCube_height:(CGFloat)cube_height {
    CGRect frame = self.frame;
    frame.size.height = cube_height;
    self.frame = frame;
}

- (CGPoint)cube_origin {
    return self.frame.origin;
}

- (void)setCube_origin:(CGPoint)cube_origin {
    CGRect frame = self.frame;
    frame.origin = cube_origin;
    self.frame = frame;
}

- (CGSize)cube_size {
    return self.frame.size;
}

- (void)setCube_size:(CGSize)cube_size {
    CGRect frame = self.frame;
    frame.size = cube_size;
    self.frame = frame;
}

@end
