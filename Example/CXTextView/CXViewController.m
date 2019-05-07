//
//  CXViewController.m
//  CXTextView
//
//  Created by 616704162@qq.com on 05/06/2019.
//  Copyright (c) 2019 616704162@qq.com. All rights reserved.
//

#import "CXViewController.h"
#import "CXCommentViewController.h"
@interface CXViewController ()

@end

@implementation CXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CXTextView";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jianshuClick:(UIButton *)sender {
    CXCommentViewController *  commentViewController = [[CXCommentViewController alloc] init];
    commentViewController.title = sender.titleLabel.text;
    commentViewController.commentViewType = CXCommentViewTypeJianShu;
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (IBAction)zhihuClick:(UIButton *)sender {
    CXCommentViewController *  commentViewController = [[CXCommentViewController alloc] init];
    commentViewController.title = sender.titleLabel.text;
    commentViewController.commentViewType = CXCommentViewTypeNormal;
    [self.navigationController pushViewController:commentViewController animated:YES];
}

@end
