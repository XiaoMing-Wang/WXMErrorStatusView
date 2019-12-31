//
//  UIView+WXMErrorStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WXMErrorConfiguration.h"

@class WXMErrorStatusView;
@interface UIView (WXMErrorStatusView)

/** 全屏点击刷新 */
@property (nonatomic, assign) BOOL fullScreenRefresh;
@property (nonatomic, assign) BOOL sameSupViewColor;

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;

/** 获取提示界面 */
- (WXMErrorStatusView *)errorStatusView;

/** 设置刷新回调 */
- (void)we_setRefreshCallback:(void (^)(void))callback;

/** 添加回调 */
- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel;

/** 开始刷新和刷新结果 */
- (void)we_refreshControlStartAnimation;
- (void)we_refreshControlStopAnimation:(BOOL)success;

@end

@interface UIViewController (WXMErrorStatusView)
@property (nonatomic, assign) BOOL fullScreenRefresh;
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;

- (WXMErrorStatusView *)errorStatusView;
- (void)we_setRefreshCallback:(void (^)(void))callback;
- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel;
- (void)we_refreshControlStartAnimation;
- (void)we_refreshControlStopAnimation:(BOOL)success;
@end
