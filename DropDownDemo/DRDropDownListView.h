//
//  DRDropDownListView.h
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  DirectionDown,
  DirectionUp
} Direction;

typedef enum : NSUInteger {
  OptionSingle,
  OptionMulti
} Option;

@interface DRDropDownListView : UIView

@property (nonatomic, strong) UILabel        *titleLabel;
@property (nonatomic, strong) UILabel        *contentLabel;
@property (nonatomic, strong) NSMutableArray *products;

- (instancetype)initWithFrame:(CGRect)frame lists:(NSArray *)lists direction:(Direction)direction  option:(Option)option;
- (void)reloadContent:(NSString *)content;

@end
