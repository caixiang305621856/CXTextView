# CXTextView

[![CI Status](https://img.shields.io/travis/616704162@qq.com/CXTextView.svg?style=flat)](https://travis-ci.org/616704162@qq.com/CXTextView)
[![Version](https://img.shields.io/cocoapods/v/CXTextView.svg?style=flat)](https://cocoapods.org/pods/CXTextView)
[![License](https://img.shields.io/cocoapods/l/CXTextView.svg?style=flat)](https://cocoapods.org/pods/CXTextView)
[![Platform](https://img.shields.io/cocoapods/p/CXTextView.svg?style=flat)](https://cocoapods.org/pods/CXTextView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![效果](https://upload-images.jianshu.io/upload_images/1767433-7e4921c0301e5480.gif?imageMogr2/auto-orient/strip)

## 使用说明

```objc
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
```

## Installation

CXTextView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CXTextView'
```

## Author

616704162@qq.com, caix@mail.open.cn

## License

CXTextView is available under the MIT license. See the LICENSE file for more info.
