//
//  JY_MessageTableViewController.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_MessageTableViewController.h"

@interface JY_MessageTableViewController ()

@end

@implementation JY_MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"时光相册";
    self.tabBarItem.title = @"浅时光23333";
    //self.title = @"消息1";
}
#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller123456 Cell %@", self.tabBarItem.title, @(indexPath.row)]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 15;
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

@end
