//
//  DoraemonDBCell.m
//  AFNetworking
//
//  Created by Chengwen.Y on 2019/5/10.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeDBCell.h"
#import "CubeDBRowView.h"

@interface CubeDBCell()

@end

@implementation CubeDBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rowView = [[CubeDBRowView alloc] init];
        [self.contentView addSubview:_rowView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _rowView.frame = self.contentView.bounds;
}

- (void)renderCellWithArray:(NSArray *)array{
    _rowView.dataArray = array;
}

@end
