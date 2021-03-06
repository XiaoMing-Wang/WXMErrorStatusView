//
//  WXMStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIView+WXMErrorStatusView.h"
#import "WXMErrorConfiguration.h"

@interface WXMErrorStatusView : UIControl
@property (nonatomic, assign) WXMErrorStatusType errorType;
@property (nonatomic, assign) WXMErrorStatusInterfaceType interfaceType;

@property (nonatomic, strong) UIImageView *erroeImgVC;
@property (nonatomic, strong) UILabel *errorMsg;
@property (nonatomic, strong) UIButton *refreshControl;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

/** 全屏点击刷新 */
@property (nonatomic, assign) BOOL fullScreenRefresh;

/** 最小高度 */
+ (CGFloat)minHeightWithType:(WXMErrorStatusInterfaceType)interfaceType;

/** 刷新按钮 */
- (void)refreshControlStartAnimation;
- (void)refreshControlStopSuccess:(BOOL)success;

/** 添加回调 */
- (void)addTarget:(id)target selector:(SEL)sel;

+ (WXMErrorStatusView *)errorsViewWithType:(WXMErrorStatusType)type;
+ (WXMErrorStatusView *)errorsViewWithType:(WXMErrorStatusType)type
                             interfaceType:(WXMErrorStatusInterfaceType)interfaceType;
@end
