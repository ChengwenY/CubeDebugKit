//
//  CubeHomeCollectionViewCell.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeHomeCollectionViewCell.h"
#import "CubeHeader.h"
#import "CubePluginTypeModel.h"

@interface CubeHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CubeHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont cube_font14];
        self.titleLabel.textColor = [UIColor cube_colorBlack6];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.iconView.image = nil;
    self.titleLabel.text = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.cube_size = CGSizeMake(34, 34);
    self.iconView.cube_left = (self.contentView.cube_width - self.iconView.cube_width)/2;
    self.iconView.cube_top = 10;
    
    self.titleLabel.cube_left = 0;
    self.titleLabel.cube_height = self.titleLabel.font.lineHeight;
    self.titleLabel.cube_bottom = self.contentView.cube_height - 10;
    self.titleLabel.cube_width = self.contentView.cube_width;
}

- (void)bindWithPluginTypeModel:(CubePluginTypeModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    [self.iconView setImage:[UIImage cube_imageNamed:model.icon]];
    self.titleLabel.text = model.title;
}

@end
