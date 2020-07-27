//
//  NEHTTPModelManager.m
//  NetworkEye
//
//  Created by coderyi on 15/11/4.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import "NEHTTPModelManager.h"

#import "NEShakeGestureManager.h"
#import "NEHTTPModel.h"
//#include "sqlite3.h"

#define kSTRDoubleMarks @"\""
#define kSQLDoubleMarks @"\"\""
#define kSTRShortMarks  @"'"
#define kSQLShortMarks  @"''"

@interface NEHTTPModelManager ()

@property (nonatomic, strong) NSMutableArray *allHttpModels;

@end

@implementation NEHTTPModelManager

- (id)init {
    self = [super init];
    if (self) {
        _sqlitePassword=kSQLitePassword;
        self.saveRequestMaxCount=kSaveRequestMaxCount;
    }
    return self;
}

+ (NEHTTPModelManager *)defaultManager {
    
    static NEHTTPModelManager *staticManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticManager=[[NEHTTPModelManager alloc] init];
//        [staticManager createTable];
    });
    return staticManager;
    
}

- (NSMutableArray *)allHttpModels
{
    if (!_allHttpModels)
    {
        _allHttpModels = @[].mutableCopy;
    }
    
    return _allHttpModels;
}

- (void)saveHttpModel:(NEHTTPModel *)httpModel
{
    [self.allHttpModels addObject:httpModel];
}

+ (NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *ducumentsDirectory = [paths objectAtIndex:0];
    NSString *str=[[NSString alloc] initWithFormat:@"%@/networkeye.sqlite",ducumentsDirectory];
    return  str;
}

- (void)createTable {
    
}

- (void)addModel:(NEHTTPModel *) aModel {
    
    if ([aModel.responseMIMEType isEqualToString:@"text/html"]) {
        aModel.receiveJSONData=@"";
    }
    
    [self saveHttpModel:aModel];
}

- (NSMutableArray *)allobjects {
    return self.allHttpModels;
}

- (void) deleteAllItem {
    [self.allHttpModels removeAllObjects];
}


#pragma mark - Utils

- (id)stringToSQLFilter:(id)str {
    
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSTRShortMarks withString:kSQLShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSTRDoubleMarks withString:kSQLDoubleMarks];
        return temp;
    }
    return str;
    
}

- (id)stringToOBJFilter:(id)str {
    
    if ( [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSQLShortMarks withString:kSTRShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSQLDoubleMarks withString:kSTRDoubleMarks];
        return temp;
    }
    return str;
    
}

@end
