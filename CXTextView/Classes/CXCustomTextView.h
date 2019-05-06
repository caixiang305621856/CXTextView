//
//  CXCustomTextView.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/6.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXCustomTextView : UITextView
/**
 占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 占位文字的颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
/**
 占位符的文字位置
 */
@property(nonatomic,assign)CGPoint placePoint;
/**
 最大字数
 */
@property (nonatomic, assign)NSInteger maxLength;
/**
 文字改变的回调（只是赋值的回调，编辑的改变不回调 有KVO监听）
 */
@property(nonatomic,copy)void (^textDidChangeHandlerBlock)(CXCustomTextView *textView);
/**
 触发到最大字数的回调
 */
@property(nonatomic,copy)void (^textLengthDidMaxHandlerBlock)(CXCustomTextView *textView);

@end

NS_ASSUME_NONNULL_END
