//
//  CXTextViewHelper.h
//  CXTextView
//
//  Created by caixiang on 2019/5/7.
//  Copyright © 2019年 616704162@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef CXTextViewHelper_h
#define CXTextViewHelper_h
#import "UIView+CXPostion.h"
#import "CXTextView.h"
#import "CXCustomTextView.h"

UIKIT_STATIC_INLINE UIEdgeInsets cx_viewSafeArea(UIView *view) {
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
#endif
    return UIEdgeInsetsZero;
}

UIKIT_STATIC_INLINE UIColor *CXRGBA(NSInteger r,NSInteger g,NSInteger b,CGFloat a) {
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a];
}

UIKIT_STATIC_INLINE UIColor *CXRGB(NSInteger r,NSInteger g,NSInteger b) {
    return CXRGBA(r,g,b,1.0f);
}

UIKIT_STATIC_INLINE UIColor *CXUIColorFromRGBA(uint32_t rgbValue, CGFloat a) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0f
                            blue:((float)(rgbValue & 0xFF))/255.0f
                           alpha:a];
}

UIKIT_STATIC_INLINE UIColor *CXUIColorFromRGB(uint32_t rgbValue) {
    return CXUIColorFromRGBA(rgbValue,1.0f);
}

#endif /* CXTextViewHelper_h */
