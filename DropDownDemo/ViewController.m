//
//  ViewController.m
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "ViewController.h"

#import "DRDropDownListView.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIButton *B_openList;
@end

@implementation ViewController 

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  DRDropDownListView *v = [[DRDropDownListView alloc] initWithFrame:CGRectMake(100, 100, 150, 50) lists:@[@"A", @"B", @"C"] direction:DirectionDown option:OptionSingle];
  v.backgroundColor = [UIColor whiteColor];
  v.titleLabel.text = @"关联产品";
  [self.view addSubview:v];
  
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
