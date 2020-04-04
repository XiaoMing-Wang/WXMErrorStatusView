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
@dynamic we_fullScreenRefresh;
@dynamic we_errorNorecord;
@dynamic we_errorRequestFail;

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType {
    [self hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    
    WXMErrorStatusView *error = [WXMErrorStatusView errorsViewWithType:errorType];
    error.we_errorRequestFail = self.we_errorRequestFail;
    error.we_errorNorecord = self.we_errorNorecord;
    error.we_yOffset = self.we_yOffset;
    error.we_backGroundColor = self.we_backGroundColor;
    [self addSubview:error];
}

- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType {
    [self hidenErrorStatusView];
    if (errorType == WXMErrorStatusTypeNormal) return;
    
    WXMErrorStatusView *error = nil;
    error = [WXMErrorStatusView errorsViewWithType:errorType interfaceType:WXMErrorFaceTypeRefresh];
    error.we_errorRequestFail = self.we_errorRequestFail;
    error.we_errorNorecord = self.we_errorNorecord;
    error.we_yOffset = self.we_yOffset;
    error.we_backGroundColor = self.we_backGroundColor;
    [self addSubview:error];
}

- (void)hidenErrorStatusView {
    WXMErrorStatusView *error = [self errorStatusView];
    CGFloat duation = (error.errorType == WXMErrorStatusTypeRequestLoading) ? 0.15 : 0;
    
    [UIView animateWithDuration:duation animations:^{
        error.alpha = 0;
    } completion:^(BOOL finished) {
        [error removeFromSuperview];
    }];
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

- (void)setWe_fullScreenRefresh:(BOOL)we_fullScreenRefresh {
    WXMErrorStatusView *errorView = self.errorStatusView;
    [errorView setFullScreenRefresh:we_fullScreenRefresh];
}

- (void)setWe_errorNorecord:(NSString *)we_errorNorecord {
    objc_setAssociatedObject(self, @selector(we_errorNorecord), we_errorNorecord, 3);
}

- (NSString *)we_errorNorecord {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWe_errorRequestFail:(NSString *)we_errorRequestFail {
    objc_setAssociatedObject(self, @selector(we_errorRequestFail), we_errorRequestFail, 3);
}

- (NSString *)we_errorRequestFail {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWe_backGroundColor:(UIColor *)we_backGroundColor {
    objc_setAssociatedObject(self, @selector(we_backGroundColor), we_backGroundColor, 1);
}

- (UIColor *)we_backGroundColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWe_yOffset:(CGFloat)we_yOffset {
    objc_setAssociatedObject(self, @selector(we_yOffset), @(we_yOffset), 1);
}

- (CGFloat)we_yOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end

@implementation UIViewController (WXMErrorStatusView)
@dynamic we_yOffset;
@dynamic we_fullScreenRefresh;
@dynamic we_backGroundColor;
@dynamic we_errorNorecord;
@dynamic we_errorRequestFail;

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

- (void)setWe_fullScreenRefresh:(BOOL)we_fullScreenRefresh {
    [self.view setWe_fullScreenRefresh:we_fullScreenRefresh];
}

- (void)setWe_errorNorecord:(NSString *)we_errorNorecord {
    self.view.we_errorNorecord = we_errorNorecord;
}

- (void)setWe_errorRequestFail:(NSString *)we_errorRequestFail {
    self.view.we_errorRequestFail = we_errorRequestFail;
}

- (void)setWe_backGroundColor:(UIColor *)we_backGroundColor {
    self.view.we_backGroundColor = we_backGroundColor;
}

- (void)setWe_yOffset:(CGFloat)we_yOffset {
    self.view.we_yOffset = we_yOffset;
}

@end
