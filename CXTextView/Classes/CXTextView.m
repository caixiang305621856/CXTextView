//
//  CXTextView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/6.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXTextView.h"
#import "CXCustomTextView.h"
#import "UIView+CXPostion.h"

@interface CXTextView()<UITextViewDelegate>
#pragma mark - UI Perproty
@property(nonatomic,strong)CXCustomTextView *textView;
@end

@implementation CXTextView

@synthesize text = _text;

#pragma mark - life Cycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textView.width = self.frame.size.width - 2 *self.h_margin;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    !self.textDidChangeHandlerBlock?:self.textDidChangeHandlerBlock(textView);
    [self updateTextViewHeight];
    !self.textHeightChangeBlock?:self.textHeightChangeBlock(self.height);
    [textView scrollRangeToVisible:NSMakeRange(textView.selectedRange.location, 1)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    !self.textViewDidBeginEditingBlock?:self.textViewDidBeginEditingBlock(textView);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    !self.textViewDidEndEditingBlock?:self.textViewDidEndEditingBlock(textView);
}

- (void)updateTextViewHeight {
    CGFloat contentSizeH = ceilf(self.textView.contentSize.height);
    //内容高度
    if (self.textView.text.length == 0) {
        contentSizeH = ceilf(self.font.lineHeight * self.initiLine);
    }
    //最大高度
    CGFloat maxHeight = ceilf(self.font.lineHeight * self.maxLine);
    //初始高度
    CGFloat initiTextViewHeight = ceilf(self.initiLine *self.font.lineHeight);
    if (contentSizeH <= maxHeight) {
        if (contentSizeH <= initiTextViewHeight) {
            self.textView.height = ceilf(initiTextViewHeight);
        }else{
            self.textView.height = ceilf(contentSizeH);
        }
    }else{
        self.textView.height = ceilf(maxHeight);
    }
    self.height = self.textView.height + 2 * self.v_margin;
}


#pragma mark - private
//初始化
- (void)initilize{
    self.h_margin  = 0;
    self.v_margin = 8;
    self.initiLine = 1;
    self.maxLine = CGFLOAT_MAX;
    self.maxLength = CGFLOAT_MAX;
    self.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.textView];
}

- (void)updateTextViewFrame{
    self.textView.frame =  CGRectMake(self.h_margin, self.v_margin, self.frame.size.width - 2 *self.h_margin, ceilf(self.initiLine *self.font.lineHeight));
    self.height = self.v_margin *2 + ceilf(self.initiLine *self.font.lineHeight);
}

#pragma mark - getter & setter
- (void)setMaxLine:(NSInteger)maxLine{
    _maxLine = maxLine;
}

- (void)setH_margin:(CGFloat)h_margin{
    _h_margin = h_margin;
    [self updateTextViewFrame];
}

- (void)setV_margin:(CGFloat)v_margin{
    _v_margin = v_margin;
    [self updateTextViewFrame];
}

- (void)setInitiLine:(NSInteger)initiLine{
    _initiLine = initiLine;
    [self updateTextViewFrame];
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.textView.font = font;
    [self updateTextViewFrame];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.textView.placeholderColor = placeholderColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textView.textColor = textColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textView.placeholder = placeholder;
}

- (void)setPlacePoint:(CGPoint)placePoint{
    _placePoint = placePoint;
    self.textView.placePoint = placePoint;
}

-(void)setMaxLength:(NSInteger)maxLength {
    _maxLength = maxLength;
    self.textView.maxLength = maxLength;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.textView.text = text;
}

- (NSString *)text {
    return self.textView.text;
}

- (CXCustomTextView *)textView{
    if (!_textView) {
        _textView =[[CXCustomTextView alloc]initWithFrame:CGRectMake(self.h_margin, self.v_margin, self.frame.size.width - 2 *self.h_margin,  self.initiLine *self.font.lineHeight)];
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.delegate = self;
        _textView.placeholder = @"请输入";
        __weak __typeof(self)weakSelf = self;
        _textView.textLengthDidMaxHandlerBlock = ^(CXCustomTextView *textView) {
            __strong __typeof(weakSelf)sSelf = weakSelf;
            !sSelf.textLengthDidMaxHandlerBlock?:sSelf.textLengthDidMaxHandlerBlock(textView);
        };
        _textView.textDidChangeHandlerBlock = ^(CXCustomTextView *textView) {
            __strong __typeof(weakSelf)sSelf = weakSelf;
            !sSelf.textDidChangeHandlerBlock?:sSelf.textDidChangeHandlerBlock(textView);
            [sSelf updateTextViewHeight];
            !sSelf.textHeightChangeBlock?:sSelf.textHeightChangeBlock(sSelf.height);
        };
    }
    return _textView;
}


@end
