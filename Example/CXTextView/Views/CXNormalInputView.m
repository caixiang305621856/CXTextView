//
//  CXNormalInputView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXNormalInputView.h"
#import "CXTextViewHelper.h"

@interface CXNormalInputView()
{
    CGFloat _keybordHeight;
    CGFloat _customTextViewHeight;
}
@property (strong, nonatomic) CXTextView *textView;
@property (strong, nonatomic)  UIButton *sendBtn;

@end

@implementation CXNormalInputView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"🔥%@",NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addNotification];
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self addNotification];
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.textView];
    [self addSubview:self.sendBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        self.top = [UIScreen mainScreen].bounds.size.height - ((self->_keybordHeight > 0)?self->_keybordHeight:cx_viewSafeArea(self.superview).bottom) - self->_customTextViewHeight;
        self.sendBtn.top = self.textView.top;
        self.sendBtn.height =  self->_customTextViewHeight;
    }];
}

#pragma mrak - private
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)sendBtnClicked {
    !self.senderClickHandler?:self.senderClickHandler(self);
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:[curve doubleValue]];
    _keybordHeight = keyboardRect.size.height;
    [UIView commitAnimations];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification*)notification{
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:[curve doubleValue]];
    _keybordHeight = 0;
    [UIView commitAnimations];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CXTextView *)textView{
    if (!_textView) {
        _textView = [[CXTextView alloc] initWithFrame:CGRectMake(0, 0, self.width - 84, 0)];
        _textView.initiLine = 1;
        _textView.maxLine = 3;
        _textView.v_margin = 10;
        _textView.h_margin = 15;
        _textView.maxLength = 500;
        _textView.placeholder = @"说点什么吧";
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textView.tintColor = CXRGB(0, 132, 255);
        _customTextViewHeight = ceil(_textView.font.lineHeight * _textView.initiLine) + 2*_textView.v_margin;
        //高度改变
        __weak __typeof(self)weakSelf = self;
        _textView.textHeightChangeBlock = ^(CGFloat height) {
            __strong __typeof(weakSelf)sSelf = weakSelf;
            if (sSelf->_customTextViewHeight != height) {
                sSelf->_customTextViewHeight = height;
                [sSelf setNeedsLayout];
                [sSelf layoutIfNeeded];
            }
        };
        //文字改变
        _textView.textDidChangeHandlerBlock = ^(UITextView *textView) {
            __strong __typeof(weakSelf)sSelf = weakSelf;
            if ([[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
                sSelf.sendBtn.userInteractionEnabled=NO;
                sSelf.sendBtn.alpha=0.6;
            } else {
                sSelf.sendBtn.userInteractionEnabled=YES;
                sSelf.sendBtn.alpha=1;
            }
        };
        //最大字数回调
        _textView.textLengthDidMaxHandlerBlock = ^(UITextView * _Nonnull textView) {
            NSLog(@"👱弹出自己业务的提示👱");
        };
    }
    return _textView;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn.titleLabel setFont: [UIFont systemFontOfSize:16]];
        _sendBtn.frame = CGRectMake(self.width - 84, 0, 84, 40);
        _sendBtn.backgroundColor = CXRGB(0, 132, 255);
        [_sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.userInteractionEnabled=NO;
        _sendBtn.alpha=0.6;
    }
    return _sendBtn;
}



@end
