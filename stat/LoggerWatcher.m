//
//  LoggerWatcher.m
//  statlibrary
//
//  Created by osx on 17/1/22.
//  Copyright © 2017年 osx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoggerWatcher.h"
#import "MessageSender.h"
#include "Utility.h"

@implementation LoggerWatcher {
    NSString *appId;
    NSString *appKey;
    NSString *channelId;
    MessageSender *messageSender;
}

- (void)startTracking:(NSString *)Id withKey:(NSString *)key withChannel:(NSString *)channel {
    messageSender = [[MessageSender alloc] init];
    [messageSender startup];
    
    appId = Id;
    appKey = key;
    channelId = channel;
    
    if (![Utility isInstalled]) {
        [Utility installed:YES];
        
        NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
        [msg setValue:@"" forKey:@"who"];
        [msg setValue:@"install" forKey:@"what"];
        [msg setValue:[self getTime] forKey:@"when"];
        [msg setValue:@"install" forKey:@"where"];
        
        NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
        [content setValue:channelId forKey:@"channelid"];
        [content setValue:appId forKey:@"appid"];
        [msg setValue:content forKey:@"content"];
        [msg setValue:[self getDeviceInfo] forKey:@"device"];
        
        [messageSender sendWithMessage:msg];
    }
    
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:@"" forKey:@"who"];
    [msg setValue:@"startup" forKey:@"what"];
    [msg setValue:[self getTime] forKey:@"when"];
    [msg setValue:@"startup" forKey:@"where"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:channelId forKey:@"channelid"];
    [content setValue:appId forKey:@"appid"];
    [msg setValue:content forKey:@"content"];
    [msg setValue:[self getDeviceInfo] forKey:@"device"];
    
    [messageSender sendWithMessage:msg];
}

- (void)trackRegistration: (NSString *) userId {
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:userId forKey:@"who"];
    [msg setValue:@"register" forKey:@"what"];
    [msg setValue:[self getTime] forKey:@"when"];
    [msg setValue:@"register" forKey:@"where"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:channelId forKey:@"channelid"];
    [content setValue:appId forKey:@"appid"];
    [msg setValue:content forKey:@"content"];
    [msg setValue:[self getDeviceInfo] forKey:@"device"];
    
    [messageSender sendWithMessage:msg];
}

- (void)trackLogin: (NSString *) userId {
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:userId forKey:@"who"];
    [msg setValue:@"loggedin" forKey:@"what"];
    [msg setValue:[self getTime] forKey:@"when"];
    [msg setValue:@"loggedin" forKey:@"where"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:channelId forKey:@"channelid"];
    [content setValue:appId forKey:@"appid"];
    [msg setValue:content forKey:@"content"];
    [msg setValue:[self getDeviceInfo] forKey:@"device"];
    
    [messageSender sendWithMessage:msg];
}

- (void)trackPurchase: (NSString *)userId order:(NSString *)transactionId payType:(NSString *)paymentType currency:(NSString *)currency price:(NSString *) amount {
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:userId forKey:@"who"];
    [msg setValue:@"payment" forKey:@"what"];
    [msg setValue:[self getTime] forKey:@"when"];
    [msg setValue:@"payment" forKey:@"where"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:channelId forKey:@"channelid"];
    [content setValue:appId forKey:@"appid"];
    [content setValue:transactionId forKey:@"transactionid"];
    [content setValue:paymentType forKey:@"paymenttype"];
    [content setValue:currency forKey:@"currencytype"];
    [content setValue:amount forKey:@"amount"];
    [msg setValue:content forKey:@"content"];
    [msg setValue:[self getDeviceInfo] forKey:@"device"];
    
    [messageSender sendWithMessage:msg];
}

- (void)trackCustom: (NSString *)eventId value:(NSString *)eventValue user:(NSString *)userId {
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] init];
    [msg setValue:userId forKey:@"who"];
    [msg setValue:eventId forKey:@"what"];
    [msg setValue:[self getTime] forKey:@"when"];
    [msg setValue:@"event" forKey:@"where"];
    
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:channelId forKey:@"channelid"];
    [content setValue:appId forKey:@"appid"];
    [content setValue:eventValue forKey:@"value"];
    [msg setValue:content forKey:@"content"];
    [msg setValue:[self getDeviceInfo] forKey:@"device"];
    
    [messageSender sendWithMessage:msg];
}

- (NSString *)getTime {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    return timeString;
}

- (NSDictionary *)getDeviceInfo {
    NSMutableDictionary *content = [[NSMutableDictionary alloc] init];
    [content setValue:[Utility getIDFA] forKey:@"deviceid"];
    [content setValue:@"" forKey:@"imei"];
    [content setValue:@"" forKey:@"imsi"];
    [content setValue:@"00-00-00-00-00-00" forKey:@"mac"];
    [content setValue:[Utility getIDFA] forKey:@"idfa"];
    [content setValue:[Utility getIDFV] forKey:@"idfv"];
    [content setValue:[Utility getDeviceName] forKey:@"device"];
    [content setValue:[Utility getDeviceModel] forKey:@"model"];
    [content setValue:[Utility getDeviceModelName] forKey:@"modelname"];
    [content setValue:[Utility getNetworkType] forKey:@"network"];
    
    return content;
}

@end
