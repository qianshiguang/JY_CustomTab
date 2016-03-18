//
//  JY_TableViewCell.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_TableViewCell.h"
#import "JY_TableViewRowAction.h"
#import "JY_RowActionButton.h"

@implementation JY_TableViewCell

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    
    BOOL iOS8Before = ([[[UIDevice currentDevice]systemVersion]compare:@"8" options:NSNumericSearch] == NSOrderedAscending);
    if (iOS8Before && (NSNotFound != [NSStringFromClass([view class]) rangeOfString:@"TableViewCellDeleteConfirmationView"].location))
    {
        [[view subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UITableView *tabView = (id)self;
        while (![tabView isKindOfClass:[UITableView class]])
        {
            tabView = (id)[tabView superview];
        }
        NSIndexPath *idxPath = [tabView indexPathForCell:self];
        NSArray *actions = [tabView.delegate tableView:tabView editActionsForRowAtIndexPath:idxPath];
        NSMutableArray *btns = [[NSMutableArray alloc] init];
        [actions enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(JY_TableViewRowAction  *action, NSUInteger idx, BOOL * _Nonnull stop){
            JY_RowActionButton *btn = [JY_RowActionButton buttonWithRowAction:action];
            [view addSubview:btn];
            [btns addObject:btn];
        }];
        CGFloat lastX = 0;
        CGFloat detalW = 0;
        if (btns.count == 1) {
            detalW = 30;
        }else if (btns.count == 2)
        {
            detalW = 33;
        }else if (btns == 3)
        {
            detalW = 34;
        }
        //等4个 5个
        CGFloat height = self.bounds.size.height;
        for (JY_RowActionButton *btn in btns) {
            CGRect rect = btn.frame;
            rect.origin.x = lastX;
            rect.origin.y = 0;
            rect.size.width += detalW;
            rect.size.height = height;
            lastX += rect.size.width;
            btn.frame = rect;
        }
    }
    [super insertSubview:view atIndex:index];
}

@end
