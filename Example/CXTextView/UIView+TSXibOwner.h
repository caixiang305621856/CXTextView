//
//  UIView+TSXibOwner.h
//  TeacherSecretary
//
//  Created by caixiang on 2018/7/18.
//  Copyright © 2018年 vernepung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TSXibOwner)

@property (weak, nonatomic) UIView *contentView;

- (void)setUp;

@end
