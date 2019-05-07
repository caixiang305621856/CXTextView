//
//  CXInputView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXInputView.h"
#import "CXToolBarView.h"
#import "CXAppDelegate.h"
#import "CXTextViewHelper.h"

@interface CXInputView() {
    CGFloat _keybordHeight;
    CGFloat _customTextViewHeight;
}

@property (strong, nonatomic) UIView *tapView;
@property (strong, nonatomic) CXTextView *textView;
@property (strong, nonatomic) CXToolBarView *toolBarView;
@property (assign, nonatomic) BOOL animation;

@end

@implementation CXInputView

+ (instancetype)inputView; {
    CXInputView *inputView = [[CXInputView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds).size.width , ([UIScreen mainScreen].bounds).size.height)];
    return inputView;
}

- (void)show:(NSString *)content {
    self.textView.text = content;
    [[CXAppDelegate shareAppDelegate].currentWindow addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.animation = YES;
    }];
    [self performSelector:@selector(becomeFirstResponse) withObject:nil afterDelay:0.01];
}

- (void)becomeFirstResponse {
    [self.textView.textView becomeFirstResponder];
}

- (void)hide {
    [self removeFromSuperview];
}

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
    [self addSubview:self.tapView];
    [self addSubview:self.toolBarView];
    [self addSubview:self.textView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.toolBarView.bottom = self.height - self->_keybordHeight;
            self.textView.bottom = self.toolBarView.top;
            self.textView.height = self->_customTextViewHeight;
        }];
    } else{
        self.toolBarView.bottom = self.height - self->_keybordHeight;
        self.textView.bottom = self.toolBarView.top;
        self.textView.height = self->_customTextViewHeight;
    }
}

- (void)tapClick {
    [self endEditing:YES];
    !self.hideWithInputTextHandler?:self.hideWithInputTextHandler(self.textView.text);
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.1];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

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
    self.tapView.alpha = 1;
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
    self.tapView.alpha = 0;
    [UIView commitAnimations];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CXTextView *)textView{
    if (!_textView) {
        _textView = [[CXTextView alloc] initWithFrame:CGRectMake(0, 0, self.width, 100)];
        _textView.initiLine = 2;
        _textView.maxLine = 4;
        _textView.v_margin = 10;
        _textView.h_margin = 15;
        _textView.maxLength = 500;
        _textView.placeholder = @"说点什么吧";
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textView.tintColor = CXRGB(234, 111, 91);
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
                sSelf.toolBarView.canClick = NO;
            } else {
                sSelf.toolBarView.canClick = YES;
            }
        };
        //最大字数回调
        _textView.textLengthDidMaxHandlerBlock = ^(UITextView * _Nonnull textView) {
            NSLog(@"👱弹出自己业务的提示👱");
        };
    }
    return _textView;
}

- (CXToolBarView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[CXToolBarView alloc] initWithFrame:CGRectMake(0, 0, self.width, 70)];
        _toolBarView.canClick = NO;
        _toolBarView.senderClickHandler = ^(CXToolBarView * _Nonnull bar) {
            NSLog(@"🚀发送🚀");
        };
    }
    return _toolBarView;
}

- (UIView *)tapView{
    if (!_tapView) {
        _tapView = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_tapView addGestureRecognizer:tapg];
        _tapView.backgroundColor = CXRGBA(0, 0, 0, 0.5);
    }
    return _tapView;
}

@end
