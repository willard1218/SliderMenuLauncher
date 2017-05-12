//
//  SliderMenuLauncher.h
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Section.h"

@class MenuItem;

@interface SliderMenuLauncher : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSArray <Section *> *sections;
- (void)showMenu;
@end
