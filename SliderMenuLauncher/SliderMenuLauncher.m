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

@implementation SliderMenuLauncher

NSString *cellId = @"cellId";
const static CGFloat cellHeight = 50;
const static CGFloat headerHeight = 50;
const static CGFloat menuWidth = 300;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
}


- (void)showMenu {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _blackView = [[UIView alloc] init];
    _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismiss:)];
    
    [_blackView addGestureRecognizer:tapGestureRecognizer];
    [window addSubview:_blackView];
    [window addSubview:self.tableView];
    
    
    
    CGFloat x = window.frame.size.width - menuWidth;
    self.tableView.frame = CGRectMake(0, 0, x, window.frame.size.height);
    
    _blackView.frame = window.frame;
    _blackView.alpha = 0;
   
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
         //[self.tableView reloadData];
        self.blackView.alpha = 1;
        self.tableView.frame = CGRectMake(0, 0, menuWidth, window.frame.size.height);
    } completion:nil];
    
}

- (void)handleDismiss:(MenuItem *)menuItem {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.blackView.alpha = 0;
        self.tableView.frame = CGRectMake(0,
                                          0,
                                          0,
                                          self.tableView.frame.size.height);
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
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger) section {
    return _sections[section].title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sections[section].menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.menuItem = _sections[indexPath.section].menuItems[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

@end
