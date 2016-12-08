//
//  DRDropDownListCell.h
//  DropDownDemo
//
//  Created by xqzh on 16/12/8.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRDropDownListCell : UITableViewCell

@property (nonatomic, strong) UIView *speratorLine;
@property (nonatomic, assign) CGFloat width;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width;

@end
