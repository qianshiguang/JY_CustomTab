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
#import "JY_TableViewCell.h"
#import "JY_RowActionButton.h"
#import "JY_TableViewRowAction.h"

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
#pragma mark - edit logic begin

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *actions = [self tableView:tableView editActionsForRowAtIndexPath:indexPath];
    NSArray *titles  = [actions valueForKeyPath:@"title"];
    return [titles componentsJoinedByString:@"拼接"];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JY_TableViewRowAction *action1 = [JY_TableViewRowAction rowActionWithStyle:JY_TableViewRowActionStyleDefaul title:@"删除" handler:^(JY_TableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"删除设备");
        
    }];
    
//    JY_TableViewRowAction *action2 = [JY_TableViewRowAction rowActionWithStyle:JY_TableViewRowActionStyleDefaul title:@"设备设置" handler:^(JY_TableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"进入更多界面");
//        
//    }];
    
    JY_TableViewRowAction *action3 = [JY_TableViewRowAction rowActionWithStyle:JY_TableViewRowActionStyleDefaul title:@"置顶" handler:^(JY_TableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"置顶");
        //        NSObject *obj = [self.objects objectAtIndex:indexPath.row];
        //        [self.objects removeObjectAtIndex:indexPath.row];
        //        [self.objects insertObject:obj atIndex:0];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];
        
        
    }];
    
    NSArray *bgColors = @[[UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0],
                          [UIColor colorWithRed:255.0f/255.0f green:156.0f/255.0f blue:3.0f/255.0f alpha:1.0],
                          [UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:1.0f/255.0f alpha:1.0]];
    
//    action2.backgroundColor = bgColors[1];
    action3.backgroundColor = bgColors[1];
    
    return @[action1,action3];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        //just handle other style  删减 增加 多选删减
        
        NSLog(@"多选删除");
    }
}

#pragma mark - edit logic end

@end
