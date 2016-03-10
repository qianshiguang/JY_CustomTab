//
//  JY_OtherTableViewController.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_OtherTableViewController.h"

@interface JY_OtherTableViewController ()

@end

@implementation JY_OtherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"我的智能看家";
    self.tabBarItem.title = @"智能看家23333";
    [self.navigationController.tabBarItem setBadgeValue:@"8"];

}

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %@", self.tabBarItem.title, @(indexPath.row)]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", @(indexPath.row + 1)]];
    [self testPush];
}

- (void)testPush {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
