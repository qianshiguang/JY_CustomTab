//
//  JY_HomeViewControllerTableViewController.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_HomeViewControllerTableViewController.h"
#import "JY_TableViewCell.h"
#import "JY_RowActionButton.h"
#import "JY_TableViewRowAction.h"

@interface JY_HomeViewControllerTableViewController ()
@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation JY_HomeViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的摄像机(3)";
    self.tabBarItem.title = @"门铃1号";
    [self.navigationController.tabBarItem setBadgeValue:@"10"];
    self.tableView.rowHeight = 90;
    int random = arc4random() % 200 + 15;
    while (random--) {
        [self.objects addObject:@(random)];
    }

}

- (NSMutableArray *)objects
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc]init];
    }
    return _objects;
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
    return self.objects.count;
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
    NSDate *date = self.objects[indexPath.row];
    cell.textLabel.text = [date description];
    [self configureCell:cell forIndexPath:indexPath];

    return cell;
}


////注意cell必须继承QLTableViewCell，我在 storyboard 里设置的！！！
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    NSDate *date = self.objects[indexPath.row];
//    cell.textLabel.text = [date description];
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *badgeNumber = @(indexPath.row + 1);
    self.navigationItem.title = [NSString stringWithFormat:@"集合摄像机门铃(%@)", badgeNumber]; //sets navigation bar title.设置导航栏标题。{动态的改变文字}
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
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
    
    JY_TableViewRowAction *action2 = [JY_TableViewRowAction rowActionWithStyle:JY_TableViewRowActionStyleDefaul title:@"设备设置" handler:^(JY_TableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"进入更多界面");
        
    }];
    
    JY_TableViewRowAction *action3 = [JY_TableViewRowAction rowActionWithStyle:JY_TableViewRowActionStyleDefaul title:@"置顶" handler:^(JY_TableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"置顶");
        NSObject *obj = [self.objects objectAtIndex:indexPath.row];
        [self.objects removeObjectAtIndex:indexPath.row];
        [self.objects insertObject:obj atIndex:0];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [tableView endUpdates];

        
    }];
    
    NSArray *bgColors = @[[UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0],
                          [UIColor colorWithRed:255.0f/255.0f green:156.0f/255.0f blue:3.0f/255.0f alpha:1.0],
                          [UIColor colorWithRed:255.0f/255.0f green:128.0f/255.0f blue:1.0f/255.0f alpha:1.0]];
    
    action2.backgroundColor = bgColors[1];
    action3.backgroundColor = bgColors[2];

    return @[action1,action2,action3];
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

