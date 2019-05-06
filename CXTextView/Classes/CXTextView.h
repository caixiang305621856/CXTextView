//
//  CXTextView.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/6.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXCustomTextView;

NS_ASSUME_NONNULL_BEGIN

@interface CXTextView : UIView

/**
 真实的textView
 */
@property(nonatomic,strong,readonly)CXCustomTextView *textView;
/**
 竖直方向上下间距 默认为8
 */
@property(nonatomic,assign)CGFloat v_margin;
/**
 水平方向上下间距 默认为0
 */
@property(nonatomic,assign)CGFloat h_margin;
/**
 初始需要展示的行数 默认为1
 */
@property(nonatomic,assign)NSInteger  initiLine;
/**
 最大行数 默认为无穷大
 */
@property(nonatomic,assign)NSInteger maxLine;
/**
 占位文字
 */
@property(nonatomic,strong)NSString *placeholder;
/**
 占位文字的颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
/**
 最大字数
 */
@property (nonatomic, assign)NSInteger maxLength;
/**
 默认为17
 */
@property(nonatomic,strong)UIFont *font;
/**
 置占位符的位置，竖直方向设置v_margin即可  CGPointMake(5, 0);//占位文字的起始位置
 */
@property(nonatomic,assign)CGPoint placePoint;
/**
 文字
 */
@property (copy, nonatomic) NSString *text;
/**
 文字颜色
 */
@property (strong, nonatomic) UIColor *textColor;
/**
 高度变化回调
 */
@property(nonatomic,copy)void (^textHeightChangeBlock)(CGFloat height);
/**
 开始编辑回调
 */
@property(nonatomic,copy)void (^textViewDidBeginEditingBlock)(UITextView *textView);
/**
 结束编辑回调
 */
@property(nonatomic,copy)void (^textViewDidEndEditingBlock)(UITextView *textView);
/**
 最大值回调
 */
@property(nonatomic,copy)void (^textLengthDidMaxHandlerBlock)(UITextView *textView);
/**
 文字变动改变回调
 */
@property(nonatomic,copy)void (^textDidChangeHandlerBlock)(UITextView *textView);

@end

NS_ASSUME_NONNULL_END
