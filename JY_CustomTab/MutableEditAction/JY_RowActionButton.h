//
//  JY_RowActionButton.h
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JY_TableViewRowAction.h"

@interface JY_RowActionButton : UIButton

@property (nonatomic, strong, readonly)JY_TableViewRowAction *rowAction;

+ (instancetype)buttonWithRowAction:(JY_TableViewRowAction *)rowAction;

@end
