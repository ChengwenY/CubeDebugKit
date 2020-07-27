//
//  DoraemonDBCell.h
//  AFNetworking
//
//  Created by Chengwen.Y on 2019/5/10.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CubeDBRowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CubeDBCell : UITableViewCell

@property (nonatomic, strong) CubeDBRowView *rowView;

- (void)renderCellWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
