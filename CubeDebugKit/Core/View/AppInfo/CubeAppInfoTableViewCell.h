//
//  CubeAppInfoTableViewCell.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeAppInfoTableViewCell : UITableViewCell


- (void)bindWithData:(NSDictionary *)data;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
