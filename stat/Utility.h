//
//  Utility.h
//  statlibrary
//
//  Created by osx on 17/1/22.
//  Copyright © 2017年 osx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)getIDFA;
+ (NSString *)getIDFV;
+ (NSString *)getDeviceName;
+ (NSString *)getSystemVersion;
+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceModelName;
+ (NSString *)getNetworkType;
+ (BOOL)isInstalled;
+ (void)installed: (BOOL)flag;

@end
