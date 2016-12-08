//
//  DRDropDownListCell.m
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRDropDownListCell.h"

@implementation DRDropDownListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _speratorLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 5, width - 20, 1)];
    _speratorLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_speratorLine];
  }
  
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
