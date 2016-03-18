//
//  JY_TableViewRowAction.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_TableViewRowAction.h"
#import "JY_TableViewRowActionInternal.h"

@implementation JY_TableViewRowAction

- (instancetype)initWithStyle:(JY_TableViewRowActionStyle)style title:(NSString *)title handler:(void (^)(JY_TableViewRowAction *action, NSIndexPath *indexPath))handler
{
    self = [super init];
    if (self) {
        self.style = style;
        self.title = title;
        self.RowActionHandler = handler;
        switch (style) {
            case JY_TableViewRowActionStyleDefaul:
            {
                self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0];
            }
                break;
            case JY_TableViewRowActionStyleNormal:
            {
                self.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0];
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}
+ (instancetype)rowActionWithStyle:(JY_TableViewRowActionStyle)style title:(NSString *)title handler:(void (^)(JY_TableViewRowAction *action, NSIndexPath *indexPath))handler;
{
    JY_TableViewRowAction *instance = nil;
    BOOL iOS8Before = ([[[UIDevice currentDevice]systemVersion]compare:@"8" options:NSNumericSearch] == NSOrderedAscending);
    if (iOS8Before) {
        instance = [[JY_TableViewRowAction alloc]initWithStyle:style title:title handler:handler];
        
    }else{
        Class class = NSClassFromString(@"UITableViewRowAction");
        instance = [class rowActionWithStyle:style title:title handler:handler];
    }

    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [JY_TableViewRowAction rowActionWithStyle:self.style title:self.title handler:self.RowActionHandler];
}

@end
