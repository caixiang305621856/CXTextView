//
//  CXJianShuToolBarView.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXJianShuToolBarView : UIView

@property (assign, nonatomic) BOOL canClick;

@property (copy, nonatomic) void(^senderClickHandler)(CXJianShuToolBarView *bar);

@end

NS_ASSUME_NONNULL_END
