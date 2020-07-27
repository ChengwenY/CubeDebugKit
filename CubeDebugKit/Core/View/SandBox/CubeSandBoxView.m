//
//  SandBoxView.m
//  HaloSlimFramework
//
//  Created by Jet on 16/1/26.
//
//

#import "CubeSandBoxView.h"
#import "UIImage+Cube.h"
#import "UIView+Cube.h"

@implementation CubeSandBoxTextView
{
    UITextView * _content;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        
        CGRect contentFrame = CGRectInset(self.bounds, 10.0f, 10.0f);
        
        _content = [[UITextView alloc] initWithFrame:contentFrame];
        _content.font = [UIFont systemFontOfSize:16.0f];
        _content.textColor = [UIColor blackColor];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.editable = NO;
        _content.dataDetectorTypes = UIDataDetectorTypeLink;
        _content.scrollEnabled = YES;
        _content.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_content];
    }
    return self;
}

- (void)setFilePath:(NSString *)path
{
    if ( [path hasSuffix:@".plist"] || [path hasSuffix:@".strings"] )
    {
        _content.text = [[NSDictionary dictionaryWithContentsOfFile:path] description];
    }
    else
    {
        NSData * data = [NSData dataWithContentsOfFile:path];
        _content.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}

- (void)setContentText:(NSString *)text
{
    _content.text = text;
}

@end

#pragma mark - CubeSandBoxImageView

@implementation CubeSandBoxImageView
{
    UIImageView *    _imageView;
    UIView *        _zoomView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.backgroundColor = [UIColor clearColor];
        
        CGRect bounds = self.bounds;
        
        _imageView = [[UIImageView alloc] initWithFrame:bounds];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        
        
        _zoomView = [[UIView alloc] initWithFrame:bounds];
        [_zoomView addSubview:_imageView];
        _zoomView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_zoomView];
    }
    return self;
}

- (void)setFilePath:(NSString *)path
{
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    
    CGFloat viewWidth = self.cube_width;
    CGFloat viewHeight = self.cube_height;
    CGFloat imageWidth = img.size.width;
    CGFloat imageHeight = img.size.height;
    BOOL isPortrait = imageHeight / viewHeight > imageWidth / viewWidth;
    CGFloat scaledImageWidth, scaledImageHeight;
    CGFloat x,y;
    CGFloat imageScale;
    if (isPortrait) {//图片竖屏分量比较大
        imageScale = imageHeight / viewHeight;
        scaledImageHeight = viewHeight;
        scaledImageWidth = imageWidth / imageScale;
        x = (viewWidth - scaledImageWidth) / 2;
        y = 0;
    } else {//图片横屏分量比较大
        imageScale = imageWidth / viewWidth;
        scaledImageWidth = viewWidth;
        scaledImageHeight = imageHeight / imageScale;
        x = 0;
        y = (viewHeight - scaledImageHeight) / 2;
    }
    _imageView.frame = CGRectMake(x, y, scaledImageWidth, scaledImageHeight);
    _imageView.image = img;
}

@end
