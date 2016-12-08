//
//  DRDropDownList.m
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRDropDownList.h"
#import "DRDropDownListCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DRDropDownList ()

@property (nonatomic) BOOL isMultiSelect;

@end

@implementation DRDropDownList

- (id)showDropDown:(UIView *)b withHeight:(CGFloat *)height withData:(NSArray *)arr animationDirection:(NSString *)direction option:(NSString *)option {
  _btnSender = b;
  animationDirection = direction;
  self.table = (UITableView *)[super init];
  if (self) {
    // Initialization code
    if (_choseArray == nil) {
      _choseArray = [NSMutableArray array];
    }
    
    CGRect btn = b.frame;
    self.list = [NSArray arrayWithArray:arr];
    if ([direction isEqualToString:@"up"]) {
      self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
      self.layer.shadowOffset = CGSizeMake(-5, -5);
    }
    else if ([direction isEqualToString:@"down"]) {
      self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
      self.layer.shadowOffset = CGSizeMake(-5, 5);
    }
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 8;
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.layer.cornerRadius = 5;
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([option isEqualToString:@"multi"]) {
      _table.allowsMultipleSelection = YES;
      _isMultiSelect                 = YES;
    }else {
      _table.allowsMultipleSelection = NO;
      _isMultiSelect                 = NO;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([direction isEqualToString:@"up"]) {
      self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
    }
    else if([direction isEqualToString:@"down"]) {
      self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
    }
    _table.frame = CGRectMake(0, 0, btn.size.width, *height);
    [UIView commitAnimations];
    [b.superview addSubview:self];
    [self addSubview:_table];
  }
  return self;
}

-(void)hideDropDown:(UIView *)b {
  CGRect btn = b.frame;
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];
  if ([animationDirection isEqualToString:@"up"]) {
    self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
  }
  else if ([animationDirection isEqualToString:@"down"]) {
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
  }
  _table.frame = CGRectMake(0, 0, btn.size.width, 0);
  [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.list count];
}


- (DRDropDownListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  DRDropDownListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[DRDropDownListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier width:_btnSender.bounds.size.width];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
  }
  
  cell.textLabel.text =[_list objectAtIndex:indexPath.row];
  cell.textLabel.textColor = [UIColor blackColor];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  //字符串
  NSString *selectRow  = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
  
  //数组中包含当前行号，设置对号
  if ([self.choseArray containsObject:selectRow]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }else{
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
  if (!_isMultiSelect) {
    [self hideDropDown:_btnSender];
    // 单选时，每次选都要清楚之前的记录
    [self.choseArray removeAllObjects];
  }

  // 记录选中行数
  NSString*  selectRow  = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
  //判断数组中有没有被选中行的行号,
  if ([self.choseArray containsObject:selectRow]) {
    [self.choseArray removeObject:selectRow];
  }else{
    [self.choseArray addObject:selectRow];
  }
  NSLog(@"你选中了第%ld",(long)indexPath.row);
  
  UITableViewCell *cell;
  NSString *contentStr;
  // 显示内容
  DRDropDownListView *listView = (DRDropDownListView *)_btnSender;
  for (NSString *selectRow in self.choseArray) {
    NSInteger indexRow = [selectRow integerValue];
    cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];
    if (contentStr) {
      contentStr = [NSString stringWithFormat:@"%@,%@",contentStr, cell.textLabel.text];
    }
    else {
      contentStr = cell.textLabel.text;
    }
  }
  
  [listView reloadContent:contentStr];

  
  //cell刷新
  NSIndexPath *index=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
  [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
  
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
  cell.backgroundColor = [UIColor whiteColor];
}

- (void) myDelegate {
  [self.delegate DRDropDownListDelegateMethod:self];
}
//master

@end

