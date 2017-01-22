//
//  ViewController.m
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#import "ViewController.h"
#import "LoggerWatcher.h"

@interface ViewController ()

@end

@implementation ViewController {
    LoggerWatcher *logger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    logger = [[LoggerWatcher alloc] init];
    [logger startTracking:@"1" withKey:@"key1" withChannel:@"channel1"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRegister:(id)sender {
    [logger trackRegistration:@"user1"];
}
- (IBAction)onLogin:(id)sender {
    [logger trackLogin:@"user1"];
}
- (IBAction)onPayment:(id)sender {
    [logger trackPurchase:@"user1" order:@"order1" payType:@"alipay" currency:@"CNY" price:@"0.99"];
}
- (IBAction)onCustom:(id)sender {
    [logger trackCustom:@"event1" value:@"value1" user:@"user1"];
}

@end
