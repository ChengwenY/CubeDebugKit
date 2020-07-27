//
//  CubeAppInfoTableViewCell.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeAppInfoTableViewCell.h"
#import "CubeHeader.h"

@interface CubeAppInfoTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation CubeAppInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor cube_colorBlack3];
        self.titleLabel.font = [UIFont cube_font16];
        [self.contentView addSubview:self.titleLabel];
        
        self.valueLabel = [[UILabel alloc] init];
        self.valueLabel.textColor = [UIColor cube_colorBlack6];
        self.valueLabel.font = [UIFont cube_font16];
        [self.contentView addSubview:self.valueLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 0, self.titleLabel.cube_width, [[self class] cellHeight]);
    self.valueLabel.frame = CGRectMake(kCubeScreenWidth-15-self.valueLabel.cube_width, 0, self.valueLabel.cube_width, [[self class] cellHeight]);
}

- (void)bindWithData:(NSDictionary *)data{
    NSString *title = data[@"title"];
    NSString *value = data[@"value"];
    
    self.titleLabel.text = title;
    
    NSString *cnValue = nil;
    if([value isEqualToString:@"NotDetermined"]){
        cnValue = @"用户没有选择";
    }else if([value isEqualToString:@"Restricted"]){
        cnValue = @"家长控制";
    }else if([value isEqualToString:@"Denied"]){
        cnValue = @"用户没有授权";
    }else if([value isEqualToString:@"Authorized"]){
        cnValue = @"用户已经授权";
    }else{
        cnValue = value;
    }
    
    self.valueLabel.text = cnValue;
    
    [self.titleLabel sizeToFit];
    [self.valueLabel sizeToFit];
}

+ (CGFloat)cellHeight{
    return 50;
}


@end
