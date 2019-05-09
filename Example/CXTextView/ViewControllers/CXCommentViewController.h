//
//  CXCommentViewController.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CXCommentViewType) {
    CXCommentViewTypeNormal       = 0,
    CXCommentViewTypeJianShu  = 1 << 0
};

@interface CXCommentViewController : UIViewController

@property (nonatomic, assign) CXCommentViewType commentViewType;

@end
