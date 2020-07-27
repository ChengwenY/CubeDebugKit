//
//  CubeDBManager.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/10.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubeDBManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, copy) NSString *tableName;

- (NSArray *)tablesAtDB;
- (NSArray *)dataAtTable;

@end

NS_ASSUME_NONNULL_END
