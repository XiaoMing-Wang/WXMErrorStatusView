//
//  UITableView+WXMErrorStatusView.h
//  Multi-project-coordination
//
//  Created by wq on 2019/12/29.
//  Copyright © 2019 wxm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIView+WXMErrorStatusView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (WXMErrorStatusView)

/** 自动管理空视图 默认NO */
@property (nonatomic, assign) BOOL automaticManagement;

/** 请求是否失败 */
@property (nonatomic, assign) BOOL requestFail;

/** 开始加载 */
- (void)startLoading;

@end

NS_ASSUME_NONNULL_END
