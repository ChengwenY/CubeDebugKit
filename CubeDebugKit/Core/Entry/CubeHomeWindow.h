//
//  CubeHomeWindow.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeHomeWindow : UIWindow

+ (instancetype)sharedInstance;

- (void)show;

- (void)hide;

- (void)showPlugin:(UIViewController *)vc;


@end

NS_ASSUME_NONNULL_END
