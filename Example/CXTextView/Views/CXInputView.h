//
//  CXInputView.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXInputView : UIView

+ (instancetype)inputView;

- (void)show:(NSString *)content;

- (void)hide;

@property (copy, nonatomic) void(^hideWithInputTextHandler)(NSString *content);

@end

NS_ASSUME_NONNULL_END
