//
//  SliderMenuLauncher.m
//  SliderMenuLauncher
//
//  Created by willard on 2017/5/7.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "SliderMenuLauncher.h"
#import "MenuItem.h"
#import "Section.h"
#import "MenuItemCell.h"
#import "UIView+Helpers.h"

@implementation SliderMenuLauncher

static NSString *cellId = @"cellId";
const static CGFloat cellHeight = 50;
const static CGFloat headerHeight = 20;
const static CGFloat menuWidth = 250;


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _backgroundColor = [UIColor colorWithRed:34.0/255 green:136.0/255 blue:179.0/255 alpha:1];
    
  
    [self addSubview:self.tableView];
    [self addSubview:self.headerView];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraintsWithFormat:@"H:|[v0]|" view:_headerView];
    [self addConstraintsWithFormat:@"H:|[v0]|" view:_tableView];
    [self addConstraintsWithFormat:@"V:|[v0(120)]-(0)-[v1]-(0)-|" views:@[_headerView, _tableView]];
}


- (void)showMenu {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _blackView = [[UIView alloc] init];
    _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismiss:)];
    
    [_blackView addGestureRecognizer:tapGestureRecognizer];
    [window addSubview:_blackView];
    [window addSubview:self];
    
    self.frame = CGRectMake(-menuWidth, 0, menuWidth, window.frame.size.height);
    
    _blackView.frame = window.frame;
    _blackView.alpha = 0;
   
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.blackView.alpha = 1;
        self.frame = CGRectMake(0, 0, menuWidth, window.frame.size.height);
    } completion:nil];
    
}

- (void)handleDismiss:(MenuItem *)menuItem {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.blackView.alpha = 0;
        
        self.frame = CGRectMake(-self.frame.size.width,
                                0,
                                self.frame.size.width,
                                self.frame.size.height);
      
    } completion:^(BOOL finished) {
        if ([menuItem isKindOfClass:MenuItem.class] && ![menuItem.name isEqualToString:@""] && ![menuItem.name isEqualToString:@"Cancel"]) {
        }
    }];
}

- (UITableView *)tableView {
    
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc] init];
    [_tableView registerClass:MenuItemCell.class forCellReuseIdentifier:cellId];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = _backgroundColor;
    
    return _tableView;
}

- (NSArray<Section *> *)sections {
    if (_sections) {
        return _sections;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"menuSource" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSMutableArray <Section *> *sections = [NSMutableArray array];
    for (NSDictionary *sectionDict in json) {
        NSString *title = sectionDict[@"sectionTitle"];
        NSMutableArray <MenuItem *> *meunItems = [NSMutableArray array];
        
        for (NSDictionary *meunItemDict in sectionDict[@"items"]) {
            MenuItem *menuItem = [[MenuItem alloc] initWithName:meunItemDict[@"name"] imageName:meunItemDict[@"imageName"]];
            
            [meunItems addObject:menuItem];
        }
        
        Section *section = [[Section alloc] init];
        section.title = title;
        section.menuItems = meunItems.copy;
        [sections addObject:section];
    }
    
    _sections = sections.copy;
    return _sections;
}

- (UIView *)headerView {
    if (_headerView) {
        return _headerView;
    }
    
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = _backgroundColor;
    
    UIImage *image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.tintColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Hi, Welcome";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    
    [_headerView addSubview:imageView];
    [_headerView addSubview:label];
    
    [_headerView addConstraintsWithFormat:@"V:|-(33)-[v0(50)]-(10)-[v1]-|" views:@[imageView, label]];
    
    
    [imageView.centerXAnchor constraintEqualToAnchor:_headerView.centerXAnchor].active = YES;
    [imageView.widthAnchor constraintEqualToConstant:50].active = YES;


    [label.centerXAnchor constraintEqualToAnchor:imageView.centerXAnchor].active = YES;
    [label.widthAnchor constraintEqualToConstant:120].active = YES;

    return _headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger) section {
    return self.sections[section].title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = _backgroundColor;
    cell.menuItem = self.sections[indexPath.section].menuItems[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.frame.size.width, headerHeight - 3)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = self.sections[section].title;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0 green:105.0/255 blue:150.0/255 alpha:1];
    [view addSubview:label];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor].active = YES;
    [label.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:10].active = YES;
    [label.heightAnchor constraintEqualToConstant:14].active = YES;;
    [label.widthAnchor constraintEqualToAnchor:view.widthAnchor].active = YES;
  
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

@end
