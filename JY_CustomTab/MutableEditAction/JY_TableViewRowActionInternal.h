
//
//  JY_TableViewRowActionInternal.h
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

@interface JY_TableViewRowAction ()

@property (nonatomic, copy) void (^RowActionHandler)(JY_TableViewRowAction *action, NSIndexPath *indexPath);
@property (nonatomic, readwrite) JY_TableViewRowActionStyle style;

@end
