//
//  JY_TableViewRowAction.h
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JY_TableViewRowActionStyle)
{
    JY_TableViewRowActionStyleDefaul = 0,
    JY_TableViewRowActionStyleDestructive = JY_TableViewRowActionStyleDefaul,
    JY_TableViewRowActionStyleNormal
};

@interface JY_TableViewRowAction : NSObject<NSCopying>

+ (instancetype)rowActionWithStyle:(JY_TableViewRowActionStyle)style title:(NSString *)title handler:(void (^)(JY_TableViewRowAction *action, NSIndexPath *indexPath))handler;

@property (nonatomic, readonly)JY_TableViewRowActionStyle style;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIColor *backgroundColor;//默认背景颜色依赖于样式

@end
