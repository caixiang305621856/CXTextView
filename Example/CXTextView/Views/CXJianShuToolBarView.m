//
//  CXJianShuToolBarView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXJianShuToolBarView.h"
#import "CXTextViewHelper.h"

@interface CXJianShuToolBarView()

@property (weak, nonatomic) UIButton *senderBtn;

@end

@implementation CXJianShuToolBarView
- (void)dealloc {
    NSLog(@"🔥%@",NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =  CXRGB(234, 111, 91);
    btn.size = CGSizeMake(70, 30);
    btn.centerY = self.centerY;
    btn.right = self.width - 20;
    btn.layer.cornerRadius = 15.0f;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    _senderBtn = btn;
    
    CGFloat w = 20;
    CGFloat h = 20;
    CGFloat m = 25;
    NSArray *imageNames = @[@"icon_comment_photo",@"icon_emoji_smile"];
    for (NSInteger i = 0;  i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i== 0) {
            btn.enabled = NO;
        }
        btn.frame =  CGRectMake(m*i + 20 + w*i, 0, w, h);
        btn.centerY = self.centerY;
        [btn setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
}

- (void)click {
    !self.senderClickHandler?:self.senderClickHandler(self);
}

- (void)setCanClick:(BOOL)canClick {
    _canClick = canClick;
    self.senderBtn.userInteractionEnabled=canClick;
    self.senderBtn.alpha=canClick?1:0.6;
}

@end
