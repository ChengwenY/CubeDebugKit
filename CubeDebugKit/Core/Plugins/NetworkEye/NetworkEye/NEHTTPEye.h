//
//  NEHTTPEye.h
//  NetworkEye
//
//  Created by coderyi on 15/11/3.
//  Copyright © 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSQLitePassword @"networkeye"
#define kSaveRequestMaxCount 300

typedef NSData*(^NERespondDataDecryptBlock)(NSData *);

@interface NEHTTPEye : NSURLProtocol
/**
 *  open or close HTTP/HTTPS monitor
 *
 *  @param enabled
 */
+ (void)setEnabled:(BOOL)enabled;

/**
 *  display HTTP/HTTPS monitor state
 *
 *  @return HTTP/HTTPS monitor state
 */
+ (BOOL)isEnabled;

// 设置data解密block
+ (void)setResponseDataDecryptBlock:(NERespondDataDecryptBlock)block;
// 用于 NEHttpModel  decrypt httpBody
+ (NSData *)decryptHttpBody:(NSData *)httpBody;


@end
