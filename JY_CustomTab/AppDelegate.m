//
//  AppDelegate.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/8.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "AppDelegate.h"
#import "JY_TabBarControllerConfig.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:2.0];

    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    JY_TabBarControllerConfig *tabBarControllerConfig =[[JY_TabBarControllerConfig alloc]init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
    [self.window makeKeyAndVisible];
    [self customizeInterface];

    return YES;
}

- (void)customizeInterface {
    [self setUpNavigationBarAppearance];
}

/**
 *  设置navigationBar样式
    系统版本不同背景图片文字的差异
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
