//
//  JY_FrendsTableViewController.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_FrendsTableViewController.h"
#import "JY_DetailsViewController.h"
#import "CYLTabBarController.h"

@interface JY_FrendsTableViewController ()

@end

@implementation JY_FrendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"好友设备";
    self.tabBarItem.title = @"设备12323333";
}


#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %@", self.tabBarItem.title, @(indexPath.row)]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    UIViewController *viewController = [[JY_DetailsViewController alloc] init];
    //    viewController.hidesBottomBarWhenPushed = YES;
    // This property needs to be set before pushing viewController to the navigationController's stack. Meanwhile as it is all base on CYLBaseNavigationController, there is no need to do this.此属性需要设置前推到navigationcontroller堆栈视图。同时，它是基于cylbasenavigationcontroller，没有必要这样做。
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
