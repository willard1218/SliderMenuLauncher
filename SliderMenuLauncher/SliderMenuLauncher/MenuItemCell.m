//
//  MenuItemCell.m
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "MenuItemCell.h"
#import "MenuItem.h"
#import "UIView+Helpers.h"
@implementation MenuItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.iconImageView];
    
    [self addConstraintsWithFormat:@"H:|-8-[v0(30)]-8-[v1]|" views: @[self.iconImageView, self.nameLabel]];
    
    [self addConstraintsWithFormat:@"V:|[v0]|" views: @[self.nameLabel]];
    
    [self addConstraintsWithFormat:@"V:[v0(30)]" views: @[self.iconImageView]];
    [self.iconImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    self.nameLabel.font = [UIFont systemFontOfSize:18];
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;
    
    UIColor *backgroundColor = [UIColor colorWithRed:34.0/255 green:136.0/255 blue:179.0/255 alpha:1];
    
    self.backgroundColor = (highlighted) ? [UIColor darkGrayColor] : backgroundColor;
    
    
    self.nameLabel.textColor = (!highlighted) ? [UIColor whiteColor] : [UIColor blackColor];
    
    self.iconImageView.tintColor = (!highlighted) ? [UIColor whiteColor] : [UIColor blackColor];
}

- (void)setMenuItem:(MenuItem *)menuItem {
    self.nameLabel.text = menuItem.name;
    
    if (menuItem.imageName) {
        self.iconImageView.image = [[UIImage imageNamed:menuItem.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.iconImageView.tintColor = [UIColor darkGrayColor];
    }
}


- (UILabel *)nameLabel {
    if (_nameLabel) {
        return _nameLabel;
    }
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"Setting";
    _nameLabel.font = [UIFont systemFontOfSize:13];
    return _nameLabel;
}

- (UIImageView *)iconImageView {
    if (_iconImageView) {
        return _iconImageView;
    }
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"settings"];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    return _iconImageView;
}
@end
