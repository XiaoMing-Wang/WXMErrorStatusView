//
//  UIView+WXMErrorStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WXMErrorStatusConfiguration.h"

@interface UIView (WXMErrorStatusView)
- (void)we_showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)we_showErrorRefreshStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)we_hidenErrorStatusView;
@end

@interface UIViewController (WXMErrorStatusView)
- (void)we_showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)we_showErrorRefreshStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)we_hidenErrorStatusView;
@end

