//
//  DoraemonDBShowView.m
//  AFNetworking
//
//  Created by Chengwen.Y on 2019/5/10.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeDBShowView.h"
#import "CubeHeader.h"

@interface CubeDBShowView()

@property (nonatomic, strong) UILabel *displayLabel;

@end

@implementation CubeDBShowView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _displayLabel = [[UILabel alloc] init];
        _displayLabel.numberOfLines = 0;
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.backgroundColor = [UIColor cube_colorWithRGB:0xAAAAAA];
        [self addSubview:_displayLabel];
    }
    return self;
}

- (void)showText:(NSString *)text{
    _displayLabel.frame = CGRectMake(self.cube_width/2-150/2, self.cube_height/2-100/2, 150, 100);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.displayLabel.frame = CGRectMake(self.cube_width/2-300/2, self.cube_height/2-200/2, 300, 200);
    } completion:^(BOOL finished) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.displayLabel.text = text;
    }];
}

@end
