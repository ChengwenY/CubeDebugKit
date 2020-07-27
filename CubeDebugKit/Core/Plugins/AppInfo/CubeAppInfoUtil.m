//
//  CubeAppInfoUtil.m
//  CubeDebugKit
//
//  Created by Chengwen.Y on 2019/5/8.
//  Copyright © 2019 Chengwen. All rights reserved.
//

#import "CubeAppInfoUtil.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>

@implementation CubeAppInfoUtil

+ (NSString *)iphoneName
{
    return [UIDevice currentDevice].name;
}

+ (NSString *)iphoneSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)bundleIdentifier
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)bundleVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleShortVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    NSString *name = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([name isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([name isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([name isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([name isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([name isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([name isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([name isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([name isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([name isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([name isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([name isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([name isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([name isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    if ([name isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([name isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([name isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([name isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([name isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([name isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([name isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([name isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([name isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([name isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([name isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([name isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([name isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([name isEqualToString:@"iPhone11,4"]) return @"iPhone XS MAX";
    if ([name isEqualToString:@"iPhone11,6"]) return @"iPhone XS MAX";
    
    return name;
}

+ (BOOL)isIpad{
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)locationAuthorization
{
    NSString *auth = @"";
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus state = [CLLocationManager authorizationStatus];
        if (state == kCLAuthorizationStatusNotDetermined) {
            auth = @"NotDetermined";
        }else if(state == kCLAuthorizationStatusRestricted){
            auth = @"Restricted";
        }else if(state == kCLAuthorizationStatusDenied){
            auth = @"Denied";
        }else if(state == kCLAuthorizationStatusAuthorizedAlways){
            auth = @"Always";
        }else if(state == kCLAuthorizationStatusAuthorizedWhenInUse){
            auth = @"WhenInUse";
        }
    }else{
        auth = @"未开启系统定位";
    }
    return auth;
}

+ (NSString *)pushAuthorization{
    
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
        return @"NO";
    }
    
    return @"YES";
}

+ (NSString *)cameraAuthorization{
    NSString *authorization = @"";
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            authorization = @"NotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            authorization = @"Restricted";
            break;
        case AVAuthorizationStatusDenied:
            authorization = @"Denied";
            break;
        case AVAuthorizationStatusAuthorized:
            authorization = @"Authorized";
            break;
        default:
            break;
    }
    return authorization;
}

+ (NSString *)audioAuthorization{
    NSString *authorization = @"";
    NSString *mediaType = AVMediaTypeAudio;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            authorization = @"NotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            authorization = @"Restricted";
            break;
        case AVAuthorizationStatusDenied:
            authorization = @"Denied";
            break;
        case AVAuthorizationStatusAuthorized:
            authorization = @"Authorized";
            break;
        default:
            break;
    }
    return authorization;
}

+ (NSString *)photoAuthorization{
    NSString *authorization = @"";
    PHAuthorizationStatus current = [PHPhotoLibrary authorizationStatus];
    switch (current) {
        case PHAuthorizationStatusNotDetermined:    //用户还没有选择(第一次)
        {
            authorization = @"NotDetermined";
        }
            break;
        case PHAuthorizationStatusRestricted:       //家长控制
        {
            authorization = @"Restricted";
        }
            break;
        case PHAuthorizationStatusDenied:           //用户拒绝
        {
            authorization = @"Denied";
        }
            break;
        case PHAuthorizationStatusAuthorized:       //已授权
        {
            authorization = @"Authorized";
        }
            break;
        default:
            break;
    }
    return authorization;
}

+ (NSString *)addressAuthorization{
    NSString *authorization = @"";
    
    if (@available(iOS 9.0, *))
    {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (authStatus) {
            case CNAuthorizationStatusAuthorized:
                authorization = @"Authorized";
                break;
            case CNAuthorizationStatusDenied:
            {
                authorization = @"Denied";
            }
                break;
            case CNAuthorizationStatusNotDetermined:
            {
                authorization = @"NotDetermined";
            }
                break;
            case CNAuthorizationStatusRestricted:
                authorization = @"Restricted";
                break;
        }
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        ABAuthorizationStatus authorStatus = ABAddressBookGetAuthorizationStatus();
        switch (authorStatus) {
            case kABAuthorizationStatusAuthorized:
                authorization = @"Authorized";
                break;
            case kABAuthorizationStatusDenied:
            {
                authorization = @"Denied";
            }
                break;
            case kABAuthorizationStatusNotDetermined:
            {
                authorization = @"NotDetermined";
            }
                break;
            case kABAuthorizationStatusRestricted:
                authorization = @"Restricted";
                break;
            default:
                break;
        }
#pragma clang diagnostic pop

    }
    
    return authorization;
}

+ (NSString *)calendarAuthorization{
    NSString *authorization = @"";
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (status) {
        case EKAuthorizationStatusNotDetermined:
            authorization = @"NotDetermined";
            break;
        case EKAuthorizationStatusRestricted:
            authorization = @"Restricted";
            break;
        case EKAuthorizationStatusDenied:
            authorization = @"Denied";
            break;
        case EKAuthorizationStatusAuthorized:
            authorization = @"Authorized";
            break;
        default:
            break;
    }
    return authorization;
}

+ (NSString *)remindAuthorization{
    NSString *authorization = @"";
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    switch (status) {
        case EKAuthorizationStatusNotDetermined:
            authorization = @"NotDetermined";
            break;
        case EKAuthorizationStatusRestricted:
            authorization = @"Restricted";
            break;
        case EKAuthorizationStatusDenied:
            authorization = @"Denied";
            break;
        case EKAuthorizationStatusAuthorized:
            authorization = @"Authorized";
            break;
        default:
            break;
    }
    return authorization;
}

+ (NSString *)bluetoothAuthority{
    return @"";
}


@end
