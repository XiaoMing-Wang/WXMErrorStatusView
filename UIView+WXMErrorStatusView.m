//
//  UIView+WXMErrorStatusView.m
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "UIView+WXMErrorStatusView.h"
#import "WXMErrorStatusView.h"
#import <objc/runtime.h>

@implementation UIView (WXMErrorStatusView)
@dynamic fullScreenRefresh;

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType {
    [self hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    WXMErrorStatusView *error = [WXMErrorStatusView errorsViewWithType:errorType];
    if (self.sameSupViewColor) error.backgroundColor = self.backgroundColor;
    [self addSubview:error];
}

- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType {
    [self hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    WXMErrorStatusView *error = [WXMErrorStatusView errorsViewWithType:errorType interfaceType:WXMErrorFaceTypeRefresh];
    if (self.sameSupViewColor) error.backgroundColor = self.backgroundColor;
    [self addSubview:error];
}

- (void)hidenErrorStatusView {
    WXMErrorStatusView *error = [self errorStatusView];
    CGFloat duation = (error.errorType == WXMErrorStatusTypeRequestLoading) ? 0.10 : 0;
    [UIView animateWithDuration:duation animations:^{
        error.alpha = 0;
    } completion:^(BOOL finished) { [error removeFromSuperview];}];
}

- (WXMErrorStatusView *)errorStatusView {
    return [self viewWithTag:WXM_ErrorSign];
}

- (void)we_setRefreshCallback:(void (^)(void))callback {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView setCallBack:[callback copy]];
}

- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView addTarget:target selector:sel];
}

/** 开始刷新和刷新结果 */
- (void)we_refreshControlStartAnimation {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView refreshControlStartAnimation];
}

- (void)we_refreshControlStopAnimation:(BOOL)success {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView we_refreshControlStopAnimation:success];
}

- (void)setFullScreenRefresh:(BOOL)fullScreenRefresh {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView setFullScreenRefresh:fullScreenRefresh];
}

- (void)setSameSupViewColor:(BOOL)sameSupViewColor {
    NSNumber *number = @(sameSupViewColor);
    SEL sel = @selector(sameSupViewColor);
    objc_setAssociatedObject(self, sel, number,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sameSupViewColor {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end

@implementation UIViewController (WXMErrorStatusView)
@dynamic fullScreenRefresh;

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType {
    [self.view showErrorStatusViewWithType:errorType];
}

- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType {
    [self.view showErrorStatusViewWithInterface:errorType];
}

- (void)hidenErrorStatusView {
    [self.view hidenErrorStatusView];
}

- (WXMErrorStatusView *)errorStatusView {
    return [self.view viewWithTag:WXM_ErrorSign];
}

- (void)we_setRefreshCallback:(void (^)(void))callback {
    [self.view we_setRefreshCallback:callback];
}

- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel {
    [self.view we_addErrorStatusTarget:target selector:sel];
}

- (void)we_refreshControlStartAnimation {
    [self.view we_refreshControlStartAnimation];
}

- (void)we_refreshControlStopAnimation:(BOOL)success {
    [self.view we_refreshControlStopAnimation:success];
}

- (void)setFullScreenRefresh:(BOOL)fullScreenRefresh {
    [self.view setFullScreenRefresh:fullScreenRefresh];
}
@end
