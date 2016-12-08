//
//  DRDropDownList.h
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRDropDownListView.h"

@class DRDropDownList;
@protocol DRDropDownListDelegate
- (void) DRDropDownListDelegateMethod: (DRDropDownList *) sender;
@end


@interface DRDropDownList : UIView <UITableViewDelegate, UITableViewDataSource>
{
  NSString *animationDirection;
}
@property (nonatomic, retain) id <DRDropDownListDelegate> delegate;
//@property (nonatomic, retain) NSString *animationDirection;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIView *btnSender;
@property(nonatomic, retain) NSArray *list;
@property (nonatomic,strong) NSMutableArray *choseArray;

-(void)hideDropDown:(UIView *)b;
- (id)showDropDown:(UIView *)b withHeight:(CGFloat *)height withData:(NSArray *)arr animationDirection:(NSString *)direction option:(NSString *)option;

//
@end

