//
//  MenuItemCell.h
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@interface MenuItemCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) MenuItem *menuItem;
@property (nonatomic, strong) UIImageView *iconImageView;
@end
