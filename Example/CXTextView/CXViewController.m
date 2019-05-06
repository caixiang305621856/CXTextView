//
//  CXViewController.m
//  CXTextView
//
//  Created by 616704162@qq.com on 05/06/2019.
//  Copyright (c) 2019 616704162@qq.com. All rights reserved.
//

#import "CXViewController.h"
#import "CXTextView.h"
#import "UIView+CXPostion.h"

@interface CXViewController ()

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CXTextView *textView = [[CXTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width - 100, 0)];
    textView.initiLine = 2;
    textView.maxLine = 4;
    textView.v_margin = 2;
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
