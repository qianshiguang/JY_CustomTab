//
//  JY_RowActionButton.m
//  JY_CustomTab
//
//  Created by Jianying Sun on 16/3/18.
//  Copyright © 2016年 Netviewtech. All rights reserved.
//

#import "JY_RowActionButton.h"
#import "JY_TableViewRowActionInternal.h"

@interface JY_RowActionButton ()

@property (nonatomic, strong, readwrite)JY_TableViewRowAction *rowAction;

@end

@implementation JY_RowActionButton

+ (instancetype)buttonWithRowAction:(JY_TableViewRowAction *)rowAction
{
    JY_RowActionButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.rowAction = rowAction;
    [btn setTitle:rowAction.title forState:UIControlStateNormal];
    [btn setTitle:rowAction.title forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn setBackgroundColor:rowAction.backgroundColor];
    [btn addTarget:btn action:@selector(clickedAction) forControlEvents:UIControlEventTouchUpInside];
    [rowAction addObserver:btn forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    [rowAction addObserver:btn forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    return btn;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([@"title" isEqualToString:keyPath]) {
        NSString *title = [change objectForKey:NSKeyValueChangeNewKey];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateHighlighted];
    }else if ([@"backgroundColor" isEqualToString:keyPath])
    {
        UIColor *bgc = [change objectForKey:NSKeyValueChangeNewKey];
        [self setBackgroundColor:bgc];
    }else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    }
}

- (void)clickedAction
{
    if (self.rowAction && self.rowAction.RowActionHandler) {
        UITableViewCell *cell = (id)self;
        while (![cell isKindOfClass:[UITableViewCell class]]) {
            cell = (id)[cell subviews];
        }
        UITableView *tb = (id)cell;
        while (![tb isKindOfClass:[UITableView class]]) {
            tb = (id)[tb superview];
        }
        NSIndexPath *indexPath = [tb indexPathForCell:cell];
        self.rowAction.RowActionHandler(self.rowAction,indexPath);
    }
}

- (void)dealloc
{
    [self.rowAction removeObserver:self forKeyPath:@"title"];
    [self.rowAction removeObserver:self forKeyPath:@"backgroundColor"];

}

@end
