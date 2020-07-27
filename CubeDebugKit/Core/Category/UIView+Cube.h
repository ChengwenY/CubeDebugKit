//
//  UIView+Cube.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/5.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Cube)

@property (nonatomic)CGFloat cube_left;
@property (nonatomic)CGFloat cube_top;
@property (nonatomic)CGFloat cube_right;
@property (nonatomic)CGFloat cube_bottom;
@property (nonatomic)CGFloat cube_width;
@property (nonatomic)CGFloat cube_height;
@property (nonatomic)CGFloat cube_centerX;
@property (nonatomic)CGFloat cube_centerY;

@property (nonatomic)CGPoint cube_origin;
@property (nonatomic)CGSize cube_size;

@end

NS_ASSUME_NONNULL_END
