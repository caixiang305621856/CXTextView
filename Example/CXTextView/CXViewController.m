//
//  CXViewController.m
//  CXTextView
//
//  Created by 616704162@qq.com on 05/06/2019.
//  Copyright (c) 2019 616704162@qq.com. All rights reserved.
//

#import "CXViewController.h"
#import "CXCommentViewController.h"
#import "UIView+CXPostion.h"
#import "CXNormalInputView.h"
@interface CXViewController ()

@end

@implementation CXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CXTextView";
    CXNormalInputView *textView = [[CXNormalInputView alloc] initWithFrame:CGRectMake(0, self.view.height - 40, self.view.width , 40)];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jianshuClick:(id)sender {
    CXCommentViewController *  commentViewController = [[CXCommentViewController alloc] init];
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (IBAction)zhihuClick:(id)sender {
}

@end
