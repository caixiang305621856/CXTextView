//
//  CXAppDelegate.h
//  CXTextView
//
//  Created by 616704162@qq.com on 05/06/2019.
//  Copyright (c) 2019 616704162@qq.com. All rights reserved.
//

@import UIKit;

@interface CXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (CXAppDelegate *)shareAppDelegate;

- (UIWindow *)currentWindow;

@end
