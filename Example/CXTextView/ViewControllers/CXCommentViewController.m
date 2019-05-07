//
//  CXCommentViewController.m
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import "CXCommentViewController.h"
#import "CXAnimationCell.h"
#import "CXTextViewHelper.h"
#import "CXJianShuCommentBottomView.h"
#import "CXInputView.h"
#import "CXNormalInputView.h"

@interface CXCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
#pragma mark - Data Perproty

#pragma mark - UI Perproty
@property (nonatomic, strong) UITableView *animationTableView;
@property (nonatomic, assign) BOOL stopAnimation;
@property (strong, nonatomic) CXJianShuCommentBottomView *jianShuCommentBottomView;
@property (strong, nonatomic) CXNormalInputView *normalInputView;

@property (strong, nonatomic) CXInputView *inputView;

@end
const CGFloat CXJianShuCommentBottomViewHeight = 88.0f;
@implementation CXCommentViewController
- (void)dealloc {
    NSLog(@"🔥%@",NSStringFromClass([self class]));
}
#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.animationTableView];
    [self.view addSubview:self.jianShuCommentBottomView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (arc4random()%2 == 1) {
            [self clickLeftRightAnimation];
        }else {
            [self clickTopAnimation];
        }
    });
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.jianShuCommentBottomView.bottom = self.view.height - cx_viewSafeArea(self.view).bottom;
    self.animationTableView.bottom = self.jianShuCommentBottomView.top;
    self.animationTableView.height = self.view.height - CXJianShuCommentBottomViewHeight - cx_viewSafeArea(self.view).bottom;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CXAnimationCell class])];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.backgroundColor = CXRGB(234, 111, 91);
}

#pragma mark - private
- (void)clickTopAnimation {
    NSArray <UITableViewCell *>*cells =   self.animationTableView.visibleCells;
    CGFloat height = ([UIScreen mainScreen].bounds).size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 44;
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.transform = CGAffineTransformMakeTranslation(0, height);
    }];
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = self.stopAnimation;
        [UIView animateWithDuration:1.5 delay:0.04 *idx usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            obj.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)clickLeftRightAnimation {
    NSArray <UITableViewCell *>*cells =  self.animationTableView.visibleCells;
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.transform = CGAffineTransformMakeTranslation(idx%2 > 0?- ([UIScreen mainScreen].bounds).size.width: ([UIScreen mainScreen].bounds).size.width, 0);
    }];
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = self.stopAnimation;
        [UIView animateWithDuration:1.5 delay:0.05 *idx usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            obj.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
}

#pragma mark - getter & setter
- (UITableView *)animationTableView {
    if (!_animationTableView) {
        _animationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  ([UIScreen mainScreen].bounds).size.width,  ([UIScreen mainScreen].bounds).size.height) style:UITableViewStylePlain];
        _animationTableView.delegate = self;
        _animationTableView.dataSource = self;
        _animationTableView.rowHeight = 80.0f;
        if (@available(iOS 11.0, *)) {
            [_animationTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
            _animationTableView.estimatedRowHeight = 0;
            _animationTableView.estimatedSectionHeaderHeight = 0;
            _animationTableView.estimatedSectionFooterHeight = 0;
            _animationTableView.contentInset = UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height + 44, 0, 0, 0);
        }
        _animationTableView.separatorColor = [UIColor whiteColor];
        [_animationTableView registerClass:[CXAnimationCell class] forCellReuseIdentifier:NSStringFromClass([CXAnimationCell class])];
    }
    return _animationTableView;
}

- (CXJianShuCommentBottomView *)jianShuCommentBottomView{
    if (!_jianShuCommentBottomView) {
        _jianShuCommentBottomView = [[CXJianShuCommentBottomView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CXJianShuCommentBottomViewHeight)];
        __weak __typeof(self)weakSelf = self;
        _jianShuCommentBottomView.senderClickHandler = ^(CXJianShuCommentBottomView *jianShuCommentBottomView) {
            //吊起输入框
            __strong __typeof(weakSelf)sSelf = weakSelf;
            [sSelf.inputView show:jianShuCommentBottomView.inputString];
        };
    }
    return _jianShuCommentBottomView;
}

- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [CXInputView inputView];
        __weak __typeof(self)weakSelf = self;
        _inputView.hideWithInputTextHandler = ^(NSString * _Nonnull content) {
            __strong __typeof(weakSelf)sSelf = weakSelf;
            sSelf.jianShuCommentBottomView.inputString = content;
            sSelf.inputView = nil;
        };
    }
    return _inputView;
}

- (CXNormalInputView *)normalInputView{
    if (!_normalInputView) {
        _normalInputView = [[CXNormalInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 48)];
    }
    return _normalInputView;
}

@end
