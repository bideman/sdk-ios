//
//  LoggerWatcher.h
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#ifndef LoggerWatcher_h
#define LoggerWatcher_h

#import <Foundation/Foundation.h>

@interface LoggerWatcher : NSObject

- (void)startTracking:(NString *)appId withKey:(NString *)key withChannel:(NString *)channelId;

@end

#endif /* LoggerWatcher_h */
