//
//  CXCustomTextView.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/6.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXCustomTextView.h"

@interface CXCustomTextView()
#pragma mark - Data Perproty
@property (nonatomic, assign) BOOL isNameTextFieldEnbable;
@end

@implementation CXCustomTextView

#pragma mark - life Cycle
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"text"];
}

- (void)drawRect:(CGRect)rect{
    if (self.hasText) return;
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
    CGFloat x = self.placePoint.x;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = self.placePoint.y;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

#pragma mark - NSNotification
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //返回删除键
    if ([text isEqualToString:@"\n"]) {
        //切换下一个
        return NO;
    }
    if ([text isEqualToString:@""]) {
        return YES;
    }else{
        return _isNameTextFieldEnbable;
    }
}

#pragma mark - Notification
/**
 * 监听文字改变
 */
- (void)textDidChange:(NSNotification *)notification {
    self.isNameTextFieldEnbable = YES;
    UITextInputMode *mode = (UITextInputMode *)[UITextInputMode activeInputModes][0];
    NSString *lang = mode.primaryLanguage;
    //汉字
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (self.text.length > self.maxLength) {
                self.text = [self.text substringToIndex:self.maxLength];
                self.isNameTextFieldEnbable = NO;
                !self.textLengthDidMaxHandlerBlock?:self.textLengthDidMaxHandlerBlock(self);
            }
        }
    }
    //非汉字状态
    else{
        if (self.text.length > self.maxLength) {
            self.text = [self.text substringToIndex:self.maxLength];
            self.isNameTextFieldEnbable = NO;
            !self.textLengthDidMaxHandlerBlock?:self.textLengthDidMaxHandlerBlock(self);
        }
    }
    // 重绘（重新调用）
    [self setNeedsDisplay];
}

#pragma mark - private
-(void)initilize{
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    self.placePoint = CGPointMake(5, 0);
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark -KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self && [keyPath isEqualToString:@"text"]) {
        !self.textDidChangeHandlerBlock?:self.textDidChangeHandlerBlock(self);
    }
}

#pragma mark - getter & setter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    //为了让kvo 监听的textviewb内容变化 能撑起contentSize，默认只是对self.text赋值self.scrollEnabled = NO;
    self.scrollEnabled = YES;
    //如果输入的文字超出最大行数,清零的时候需要将contentSizeOffset置空,可以让绘制的placeholde位置能正确显示
    if (text.length == 0) {
        [self setContentOffset:CGPointZero];
    }
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)setPlacePoint:(CGPoint)placePoint{
    _placePoint = placePoint;
    [self setNeedsDisplay];
}

@end
