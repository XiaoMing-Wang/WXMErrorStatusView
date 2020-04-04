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
@property (nonatomic, assign) BOOL we_fullScreenRefresh;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *we_backGroundColor;

/** 文字 */
@property (nonatomic, copy) NSString *we_errorNorecord;
@property (nonatomic, copy) NSString *we_errorRequestFail;

/** y轴偏移 */
@property (nonatomic, assign) CGFloat we_yOffset;

/** 点击block */
@property (nonatomic, copy) void (^we_refreshCallback) (void);

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;

/** 设置刷新回调 */
- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel;
- (void)we_refreshControlStartAnimation;
- (void)we_refreshControlStopSuccess:(BOOL)success;

@end

@interface UIViewController (WXMErrorStatusView)
@property (nonatomic, assign) CGFloat we_yOffset;
@property (nonatomic, assign) BOOL we_fullScreenRefresh;
@property (nonatomic, strong) UIColor *we_backGroundColor;
@property (nonatomic, copy) NSString *we_errorNorecord;
@property (nonatomic, copy) NSString *we_errorRequestFail;
@property (nonatomic, copy) void (^we_refreshCallback) (void);

- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)showErrorStatusViewWithInterface:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;

- (void)we_addErrorStatusTarget:(id)target selector:(SEL)sel;
- (void)we_refreshControlStartAnimation;
- (void)we_refreshControlStopSuccess:(BOOL)success;
@end
