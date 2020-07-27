//
//  CubeAppInfoUtil.h
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface CubeAppInfoUtil : NSObject
// "my iphone"
+ (NSString *)iphoneName;

//'4.0'
+ (NSString *)iphoneSystemVersion;

// 'com.apple.xxx'
+ (NSString *)bundleIdentifier;

+ (NSString *)bundleVersion;

+ (NSString *)bundleShortVersionString;

// iphone 6 plus
+ (NSString *)deviceName;


+ (BOOL)isIpad;

+ (NSString *)locationAuthorization;

+ (NSString *)pushAuthorization;

+ (NSString *)cameraAuthorization;

+ (NSString *)audioAuthorization;

+ (NSString *)photoAuthorization;

+ (NSString *)addressAuthorization;

+ (NSString *)calendarAuthorization;

+ (NSString *)remindAuthorization;

+ (NSString *)bluetoothAuthority;
@end

NS_ASSUME_NONNULL_END
