//
//  UIView+WXMErrorStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//


#import <UIKit/UIKit.h>
#import " WXMErrorConfiguration.h"

@interface UIView (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end

@interface UIViewController (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end
