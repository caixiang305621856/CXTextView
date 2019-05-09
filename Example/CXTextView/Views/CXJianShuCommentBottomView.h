//
//  CXJianShuCommentBottomView.h
//  CXTextView_Example
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXJianShuCommentBottomView : UIView

@property (copy, nonatomic) void(^senderClickHandler)(CXJianShuCommentBottomView *jianShuCommentBottomView);
/**
 输入的文字
 */
@property (copy, nonatomic) NSString *inputString;


@end
