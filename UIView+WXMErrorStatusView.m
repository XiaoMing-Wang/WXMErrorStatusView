//
//  UIView+WXMErrorStatusView.m
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "UIView+WXMErrorStatusView.h"
#import "WXMErrorStatusView.h"

@implementation UIView (WXMErrorStatusView)
- (void)we_showErrorStatusViewWithType:(WXMErrorStatusType)errorType {
    [self we_hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    WXMErrorStatusView *error = [WXMErrorStatusView wxm_errorsViewWithType:errorType];
    [self addSubview:error];
}

- (void)we_showErrorRefreshStatusViewWithType:(WXMErrorStatusType)errorType {
    [self we_hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    WXMErrorStatusView *error = [WXMErrorStatusView wxm_errorsViewWithType:errorType
                                                             interfaceType:WXMErrorFaceTypeRefresh];
    [self addSubview:error];
}

- (void)we_hidenErrorStatusView {
     [[self viewWithTag:WXM_ErrorSign] removeFromSuperview];
}

@end

@implementation UIViewController (WXMErrorStatusView)

- (void)we_showErrorStatusViewWithType:(WXMErrorStatusType)errorType {
    [self.view we_showErrorStatusViewWithType:errorType];
}

- (void)we_showErrorRefreshStatusViewWithType:(WXMErrorStatusType)errorType {
     [self.view we_showErrorRefreshStatusViewWithType:errorType ];
}

- (void)we_hidenErrorStatusView {
    [self.view we_hidenErrorStatusView];
}
@end

