//
//  JY_AddDeviceButton.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/9.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_AddDeviceButton.h"

@interface JY_AddDeviceButton ()<UIActionSheetDelegate>

{
    CGFloat _buttonImageHeight;
}

@end

@implementation JY_AddDeviceButton


#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 创建一个标题自定义UIButton和将它添加到我们的标签栏的中心
 *
 */
//+ (instancetype)plusButton {
//    
//    JY_AddDeviceButton *button = [[JY_AddDeviceButton alloc] init];
//    
//    [button setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//    [button setTitle:@"添加" forState:UIControlStateNormal];
//    
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit];
//    
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
+ (instancetype)plusButton
{

    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];

    JY_AddDeviceButton* button = [JY_AddDeviceButton buttonWithType:UIButtonTypeCustom];

    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"购买", @"添加摄像机", @"添加门铃", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}

#pragma mark - CYLPlusButtonSubclassing
//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 3;
//}

+ (CGFloat)multiplerInCenterY {
    return  0.3;
}

@end
