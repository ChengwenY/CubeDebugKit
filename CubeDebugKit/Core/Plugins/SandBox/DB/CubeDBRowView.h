//
//  DoraemonDBRowView.h
//  AFNetworking
//
//  Created by Chengwen.Y on 2019/5/10.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CubeDBRowView;

typedef NS_ENUM(NSInteger, DoraemonDBRowViewType) {
    CubeDBRowViewTypeForTitle  = 0,
    CubeDBRowViewTypeForOne   = 1,
    CubeDBRowViewTypeForTwo   = 2
    
};

@protocol CubeDBRowTapProtocol <NSObject>

- (void)rowView:(CubeDBRowView *)rowView didLabelTaped:(UILabel *)label;

@end


@interface CubeDBRowView : UIView

@property(nonatomic, copy) NSArray *dataArray;

@property(nonatomic, assign) DoraemonDBRowViewType type;

@property(nonatomic, weak) id<CubeDBRowTapProtocol> delegate;

@end

