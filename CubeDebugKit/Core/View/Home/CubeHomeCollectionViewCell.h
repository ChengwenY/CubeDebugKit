//
//  CubeHomeCollectionViewCell.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CubePluginTypeModel;
@interface CubeHomeCollectionViewCell : UICollectionViewCell


- (void)bindWithPluginTypeModel:(CubePluginTypeModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
