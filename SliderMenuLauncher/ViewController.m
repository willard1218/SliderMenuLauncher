//
//  ViewController.m
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ViewController.h"
#import "SliderMenuLauncher.h"
@interface ViewController ()
@property SliderMenuLauncher *sliderMenuLauncher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"show menu" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}


- (void)showMenu {
    _sliderMenuLauncher = [[SliderMenuLauncher alloc] init];
    [_sliderMenuLauncher showMenu];
}


@end
