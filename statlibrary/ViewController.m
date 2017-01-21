//
//  ViewController.m
//  statlibrary
//
//  Created by osx on 2017/1/21.
//  Copyright © 2017年 osx. All rights reserved.
//

#import "ViewController.h"
#import "MessageSender.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [MessageSender new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
