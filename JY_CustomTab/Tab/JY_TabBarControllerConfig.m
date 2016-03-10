//
//  JY_TabBarControllerConfig.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/8.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_TabBarControllerConfig.h"

@import Foundation;
@import UIKit;
@interface JY_BaseNavigationController : UINavigationController
@end
@implementation JY_BaseNavigationController

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
 // fix strange animate when use `-[UIViewController cyl_jumpToOtherTabBarControllerItem:(Class)ClassType performSelector:arguments:returnValue:]` ,like this http://i63.tinypic.com/bg766g.jpg . If you have not used this method delete this line blow.
    
    [(CYLTabBarController *)self.tabBarController rootWindow].backgroundColor = [UIColor redColor];
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}
@end

//view Controllers
#import "JY_HomeViewControllerTableViewController.h"
#import "JY_MessageTableViewController.h"
#import "JY_OtherTableViewController.h"
#import "JY_FrendsTableViewController.h"

@interface JY_TabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end
@implementation JY_TabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */

- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        JY_HomeViewControllerTableViewController *firstVC = [[JY_HomeViewControllerTableViewController alloc] init];
        UIViewController * firstNavigationController = [[JY_BaseNavigationController alloc] initWithRootViewController:firstVC];
        JY_FrendsTableViewController *secondVC = [[JY_FrendsTableViewController alloc] init];
        UIViewController * secondNavigationController = [[JY_BaseNavigationController alloc] initWithRootViewController:secondVC];
        JY_MessageTableViewController *thirdVC = [[JY_MessageTableViewController alloc] init];
        UIViewController *thirdNavigationController = [[JY_BaseNavigationController alloc] initWithRootViewController:thirdVC];
        JY_OtherTableViewController *fourthVC = [[JY_OtherTableViewController alloc] init];
        UIViewController *fourthNavigationController = [[JY_BaseNavigationController alloc] initWithRootViewController:fourthVC];
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController]];
                                               
                                               
    // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性]];
        
#warning IF YOU NEED CUSTOMIZE TABBAR APPEARANCE, REMOVE THE COMMENT '//'

//        [[self class] customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        
    }

    return _tabBarController;
}
    // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController
{
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"我的摄像机",
                            CYLTabBarItemImage:@"home_normal",
                            CYLTabBarItemSelectedImage:@"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"好友摄像机",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"时光相册",
                            CYLTabBarItemImage : @"message_normal",
                            CYLTabBarItemSelectedImage : @"message_highlight",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"智能看家",
                            CYLTabBarItemImage : @"account_normal",
                            CYLTabBarItemSelectedImage : @"account_highlight"
                            };

    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */

+ (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController
{
    //去除TabBar自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    NSUInteger allItemsInTabBarCount = [CYLTabBarController allItemsInTabBarCount];
    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor brownColor] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/allItemsInTabBarCount, 49.f) withCornerRadius:0]];
    
    // set the bar background color
    //设置背景图片 bar background color
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];

}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}

@end
