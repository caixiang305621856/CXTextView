//
//  CXJianShuCommentBottomView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXJianShuCommentBottomView.h"
#import "UIView+TSXibOwner.h"

@interface CXJianShuCommentBottomView ()
#pragma mark - Data Perproty

#pragma mark - UI Perproty
@property (weak, nonatomic) IBOutlet UIButton *senderBtn;
@end

@implementation CXJianShuCommentBottomView
- (void)dealloc {
    NSLog(@"🔥%@",NSStringFromClass([self class]));
}
#pragma mark - life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        [self setUpConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
        [self setUpConfig];
    }
    return self;
}

#pragma mark - IBAction
- (IBAction)senderClick:(id)sender {
    !self.senderClickHandler?:self.senderClickHandler(self);
}

#pragma mark - private
- (void)setUpConfig {
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getter & setter
- (void)setInputString:(NSString *)inputString {
    _inputString = [inputString copy];
    if ([[_inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        [self.senderBtn setTitle:@"写下你的评论" forState:UIControlStateNormal];
        [self.senderBtn setTitle:@"写下你的评论" forState:UIControlStateHighlighted];
    } else {
        [self.senderBtn setTitle:inputString forState:UIControlStateNormal];
        [self.senderBtn setTitle:inputString forState:UIControlStateHighlighted];
    }
}

@end
