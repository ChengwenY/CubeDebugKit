//
//  SandBoxView.h
//  HaloSlimFramework
//
//  Created by Jet on 16/1/26.
//
//

#import <UIKit/UIKit.h>


@interface CubeSandBoxTextView : UIView


- (void)setFilePath:(NSString *)path;
- (void)setContentText:(NSString *)text;

@end

#pragma mark -

@interface CubeSandBoxImageView : UIView

- (void)setFilePath:(NSString *)path;

@end
