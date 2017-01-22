//
//  LoggerWatcher.h
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LoggerWatcher : NSObject

- (void)startTracking:(NSString *)Id withKey:(NSString *)key withChannel:(NSString *)channel;
- (void)trackRegistration: (NSString *) userId;
- (void)trackLogin: (NSString *) userId;
- (void)trackPurchase: (NSString *)userId order:(NSString *)transactionId payType:(NSString *)paymentType currency:(NSString *)currency price:(NSString *) amount;
- (void)trackCustom: (NSString *)eventId value:(NSString *)eventValue user:(NSString *)userId;

@end

