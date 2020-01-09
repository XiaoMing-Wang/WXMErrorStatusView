//
//   WXMErrorConfiguration.h
//  Multi-project-coordination
//
//  Created by wq on 2019/12/29.
//  Copyright © 2019 wxm. All rights reserved.
//

#ifndef _WXMErrorConfiguration_h
#define _WXMErrorConfiguration_h

#define WXM_ERGBColor(r, g, b) \
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define WXM_MinH 60
#define WXM_ErrorSign 1020

/** 无按钮垂直偏移 */
#define WXM_Offset -35

/** 有按钮垂直偏移 */
#define WXM_OffsetRefresh -35

#define WXM_RefreshWidth 120

#define WXM_RefreshCornerRadius 3

#define WXM_IMGSize CGSizeZero  /* CGSizeMake(10, 10) CGSizeZero */

#define WXM_BackgroundColor WXM_ERGBColor(245, 245, 245)
#define WXM_TextColor WXM_ERGBColor(88, 88, 88)
#define WXM_RefreshTextcolor WXM_ERGBColor(99, 99, 99)
#define WXM_RefreshBgcolor WXM_BackgroundColor

/** key为图片名字 value为文字 */
#define WXMErrorStatusTypeNormalInfo        @{@"": @""}
#define WXMErrorStatusTypeBadNetworkInfo    @{@"": @""}
#define WXMErrorStatusTypeNorecordInfo      @{@"": @""}
#define WXMErrorStatusTypeRequestFailInfo   @{@"": @""}
#define WXMErrorStatusTypeCustomInfo        @{@"": @""}
#define WXM_RefreshText @"点击刷新"

typedef NS_ENUM(NSUInteger, WXMErrorStatusType) {
    WXMErrorStatusTypeNormal = 0,     /** 正常 */
    WXMErrorStatusTypeBadNetwork,     /** 无网络 */
    WXMErrorStatusTypeNorecord,       /** 无记录 */
    WXMErrorStatusTypeRequestFail,    /** 请求失败 */
    WXMErrorStatusTypeRequestLoading, /** 加载中 */
    WXMErrorStatusTypeCustom,         /** 自定义 */
};

typedef NS_ENUM(NSUInteger, WXMErrorStatusInterfaceType) {
    WXMErrorFaceTypeNone = 0, /** 预留 */
    WXMErrorFaceTypeDefault,  /** 无按钮 */
    WXMErrorFaceTypeRefresh,  /** 有按钮 */
};

#endif /* _WXMErrorConfiguration_h */
