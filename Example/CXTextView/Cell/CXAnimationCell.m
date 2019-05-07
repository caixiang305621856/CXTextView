//
//  CXAnimationCell.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXAnimationCell.h"
#import "UIView+CXPostion.h"

@implementation CXAnimationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width = ([UIScreen mainScreen].bounds).size.width - 2*10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 70)];
        label.text = @"InputView";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
