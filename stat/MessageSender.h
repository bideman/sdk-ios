//
//  MessageSender.h
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#ifndef MessageSender_h
#define MessageSender_h

#import <Foundation/Foundation.h>

@interface MessageSender : NSObject<NSURLSessionDelegate>

- (void)startup;
- (void)sendWithMessage: (NSDictionary *)message;
- (void)shutdown;

@end

#endif /* MessageSender_h */
