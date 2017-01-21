//
//  MessageSender.m
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#import "MessageSender.h"

@implementation MessageSender {
    NSMutableArray *queue;
    NSLock *threadLock;
    BOOL isThreadRunning;
    NSURLSession *session;
}

- (void)startup {
    isThreadRunning = YES;
    queue = [NSMutableArray array];
    threadLock = [[NSLock alloc] init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun:) object:nil];
    [thread start];
}

- (void)shutdown {
    isThreadRunning = NO;
}

- (void)sendWithMessage:(NSDictionary *)message {
    if ([queue count] > 200)
        return;
    [threadLock lock];
    [queue addObject:message];
    [threadLock unlock];
    
}

- (void)threadRun: (NSInteger *)param {
    while (isThreadRunning) {
        if ([queue count] == 0) {
            [NSThread sleepForTimeInterval:0.3];
            continue;
        }
        
        NSDictionary *dict = nil;
        [threadLock lock];
        dict = (NSDictionary *)[queue objectAtIndex:0];
        [queue removeObject:dict];
        [threadLock unlock];
        
        [self postWithData:dict];
    }
}


- (void)postWithData:(NSDictionary *)body {
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return;
    }

    NSDictionary *headers = @{ @"accept": @"application/json", @"content-type": @"application/json" };
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    if (request == nil) {
        return;
    }
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:jsondata];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([response isKindOfClass: [NSURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode != 200) {
                [threadLock lock];
                [queue addObject:body];
                [threadLock unlock];
            }
        }
        
        //NSError *jerror;
        //NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jerror];
    }];
    
    [dataTask resume];
}


-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
        
        if (completionHandler) {
            completionHandler(disposition, credential);
        }
    }
}

@end
