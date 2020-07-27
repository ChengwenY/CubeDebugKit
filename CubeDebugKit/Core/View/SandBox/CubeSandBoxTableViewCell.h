//
//  CubeSandBoxTableViewCell.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CubeSandBoxModel;
@interface CubeSandBoxTableViewCell : UITableViewCell

- (void)bindWithData:(CubeSandBoxModel *)model;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
