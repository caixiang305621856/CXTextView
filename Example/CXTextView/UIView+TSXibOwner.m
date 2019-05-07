//
//  UIView+TSXibOwner.m
//  TeacherSecretary
//
//  Created by caixiang on 2018/7/18.
//  Copyright © 2018年 vernepung. All rights reserved.
//

#import "UIView+TSXibOwner.h"
#import <objc/runtime.h>

@interface UIView ()


@end

static void *TSContentViewKey = &TSContentViewKey;

@implementation UIView (TSXibOwner)
- (void)setContentView:(UIView *)contentView {
    objc_setAssociatedObject(self, &TSContentViewKey, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)contentView {
    return objc_getAssociatedObject(self, &TSContentViewKey);
}

- (void)setUp {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *view = [array firstObject];
    view.frame = self.bounds;
    [self addSubview:view];
    self.contentView = view;
}

@end
