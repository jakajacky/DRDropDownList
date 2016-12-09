//
//  DRDropDownListView.m
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRDropDownListView.h"
#import "DRDropDownList.h"

@interface DRDropDownListView () <UIGestureRecognizerDelegate, DRDropDownListDelegate>

@property (nonatomic, strong) UIImageView    *arrow;

@property (nonatomic, strong) DRDropDownList *dropDown;
@property (nonatomic, strong) NSArray        *lists;
@property (nonatomic)         Direction      direction;
@property (nonatomic)         Option         option;


@end

@implementation DRDropDownListView

- (instancetype)initWithFrame:(CGRect)frame lists:(NSArray *)lists direction:(Direction)direction option:(Option)option {
  self = [super initWithFrame:frame];
  if (self) {
    _lists     = lists;
    _direction = direction;
    _option    = option;
    
    [self addSubviews];
    [self addGesture];
  }
  return self;
}

- (void)addSubviews {
  _titleLabel = [[UILabel alloc] initWithFrame:
             CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2.0)];
  _titleLabel.backgroundColor = [UIColor whiteColor];
  [self addSubview:_titleLabel];
  
  _contentLabel = [[UILabel alloc] initWithFrame: CGRectMake(0,
                                                             self.bounds.size.height / 2.0,
                                                             self.bounds.size.width,
                                                             self.bounds.size.height / 2.0)];
  _contentLabel.backgroundColor = [UIColor whiteColor];
  [self addSubview:_contentLabel];
}

- (void)addGesture {
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
  tap.numberOfTouchesRequired = 1; //手指数
  tap.numberOfTapsRequired = 1; //tap次数
  tap.delegate = self;
  [self addGestureRecognizer:tap];
}

#pragma mark - 刷新内容
- (void)reloadContent:(NSString *)content {
  if (content) {
    _contentLabel.text = content;
    
  }
  else {
    _contentLabel.text = @"";
  }
}

- (void)tapEvent:(UITapGestureRecognizer *)sender {
  if (_dropDown == nil) {
    CGFloat dropDownListHeight = _lists.count * 40 - 1; //Set height of drop down list
    NSString *direction;
    
    if (_direction == DirectionDown) {
      direction = @"down";
    }
    else {
      direction = @"up";
    }
    NSString *option;
    if (_option == OptionMulti) {
      option = @"multi";
    }
    else {
      option = @"single";
    }
    
    _dropDown = [[DRDropDownList alloc] showDropDown:sender.view withHeight:&dropDownListHeight withData:_lists animationDirection:direction option:option];
    _dropDown.delegate = self;
  }
  else if(_dropDown.frame.size.height == 0) {
    CGFloat dropDownListHeight = _lists.count * 40 - 1; //Set height of drop down list
    NSString *direction;
    
    if (_direction == DirectionDown) {
      direction = @"down";
    }
    else {
      direction = @"up";
    }
    NSString *option;
    if (_option == OptionMulti) {
      option = @"multi";
    }
    else {
      option = @"single";
    }
    [_dropDown showDropDown:sender.view withHeight:&dropDownListHeight withData:_lists animationDirection:direction option:option];
    _dropDown.delegate = self;
    
  }
  else {
    [_dropDown hideDropDown:sender.view];
    [self closeDropDown];
  }
}

- (void) DRDropDownListDelegateMethod: (DRDropDownList *) sender {
  [self closeDropDown];
}

-(void)closeDropDown{
//  _dropDown = nil;
}


@end
