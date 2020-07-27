
//
//  CubeHomeSectionHeaderView.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/6.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeHomeSectionHeaderView.h"
#import "CubeHeader.h"

@interface CubeHomeSectionHeaderView ()

@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UIView *grayBgView;

@end

@implementation CubeHomeSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.grayBgView = [[UIView alloc] init];
        self.grayBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.grayBgView];
        
        self.backgroundColor = [UIColor whiteColor];
        self.headerTitleLabel = [[UILabel alloc] init];
        self.headerTitleLabel.textColor = [UIColor cube_colorBlack3];
        self.headerTitleLabel.font = [UIFont cube_font18B];
        [self addSubview:self.headerTitleLabel];
        
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.headerTitleLabel.text = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.grayBgView.frame = CGRectMake(0, 0, self.cube_width, 20);
    
    self.headerTitleLabel.cube_left = 10;
    self.headerTitleLabel.cube_height = self.headerTitleLabel.font.lineHeight;
    self.headerTitleLabel.cube_top = 20 + (self.cube_height - 20 - self.headerTitleLabel.cube_height)/2;
    self.headerTitleLabel.cube_width = self.cube_width - 20;
}

- (void)bindWithTitle:(NSString *)title
{
    self.headerTitleLabel.text = title;
}

@end
