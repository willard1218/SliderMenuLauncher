//
//  Section.h
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MenuItem;
@interface Section : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <MenuItem *> *menuItems;
@end
