//
//  CubeSandBoxTableViewCell.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/9.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeSandBoxTableViewCell.h"
#import "CubeHeader.h"
#import "CubeSandBoxModel.h"
@interface CubeSandBoxTableViewCell ()

@property (nonatomic, strong) UIImageView *fileTypeIcon;
@property (nonatomic, strong) UILabel *fileTitleLabel;
@property (nonatomic, strong) UILabel *fileSizeLabel;

@end

@implementation CubeSandBoxTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.fileTypeIcon = [[UIImageView alloc] init];
        self.fileTypeIcon.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.fileTypeIcon];
        
        self.fileTitleLabel = [[UILabel alloc] init];
        self.fileTitleLabel.font = [UIFont cube_font16];
        self.fileTitleLabel.textColor = [UIColor cube_colorBlack3];
        self.fileTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView addSubview:self.fileTitleLabel];
        
        self.fileSizeLabel = [[UILabel alloc] init];
        self.fileSizeLabel.font = [UIFont cube_font16];
        self.fileSizeLabel.textColor = [UIColor cube_colorBlack6];
        [self.contentView addSubview:self.fileSizeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.fileTypeIcon.frame = CGRectMake(15, ([[self class] cellHeight] - 25)/2, 25, 25);
    self.fileTitleLabel.frame = CGRectMake(self.fileTypeIcon.cube_right + 10, ([[self class] cellHeight] - self.fileTitleLabel.cube_height)/2, kCubeScreenWidth - 150, self.fileTitleLabel.cube_height);

    self.fileSizeLabel.frame = CGRectMake(kCubeScreenWidth - 10 - self.fileSizeLabel.cube_width, ([[self class] cellHeight] - self.fileSizeLabel.cube_height)/2, self.fileSizeLabel.cube_width, self.fileSizeLabel.cube_height);

}

- (void)bindWithData:(CubeSandBoxModel *)model
{
    NSString *iconName = nil;
    if (model.type == ECubeSandBoxFileTypeDirectory) {
        iconName = @"cube-dir";
    } else if (model.type == ECubeSandBoxFileTypeImage) {
        iconName = @"cube-img";
    } else if (model.type == ECubeSandBoxFileTypeDB) {
        iconName = @"cube-sql";
    } else if (model.type == ECubeSandBoxFileTypeAV) {
        iconName = @"cube-video";
    } else {
        iconName = @"cube-file";
    }
    
    
    self.fileTypeIcon.image = [UIImage cube_imageNamed:iconName];
    [self.fileTypeIcon sizeToFit];
    
    self.fileTitleLabel.text = model.name;
    [self.fileTitleLabel sizeToFit];
    
    self.fileSizeLabel.text = model.size;
    [self.fileSizeLabel sizeToFit];
}

+ (CGFloat)cellHeight{
    return 48.;
}
@end
