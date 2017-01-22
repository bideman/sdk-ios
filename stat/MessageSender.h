//
//  MessageSender.h
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageSender : NSObject<NSURLSessionDelegate>

- (void)startup;
- (void)sendWithMessage: (NSDictionary *)message;
- (void)shutdown;

@end

