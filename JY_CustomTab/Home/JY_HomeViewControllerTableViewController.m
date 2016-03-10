//
//  JY_HomeViewControllerTableViewController.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_HomeViewControllerTableViewController.h"

@interface JY_HomeViewControllerTableViewController ()

@end

@implementation JY_HomeViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"我的摄像机(3)"; //✅sets navigation bar title.The right way to set the title of the navigation设置导航栏标题，设置导航标题的正确方法
    self.tabBarItem.title = @"门铃1号";   //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.设置标签栏标题。即使` tabbaritem。标题`改变，这将忽略TabBar。
    //self.title = @"首页1";                //❌sets both of these. Do not do this‼️‼️This may cause something strange like this : http://i68.tinypic.com/282l3x4.jpg .
    [self.navigationController.tabBarItem setBadgeValue:@"10"];


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ controller cell %@",self.tabBarItem.title,@(indexPath.row)]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    // Configure the cell...
    return cell;
     */

//     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//     // Configure the cell...
//        [self configureCell:cell forIndexPath:indexPath];
//这种单元格复用的方法 要与storyboard来关联使用的 分为静态 动态 两种类型 在storyboard中要填写对应的标识符
    
//     return cell;
    
//纯代码来配置单元格 单元格复用的方法 如下创建静态单元格方法 
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *badgeNumber = @(indexPath.row + 1);
    self.navigationItem.title = [NSString stringWithFormat:@"摄像机门铃(%@)", badgeNumber]; //sets navigation bar title.设置导航栏标题。
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
}

@end
