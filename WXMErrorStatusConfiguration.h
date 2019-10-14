//
//  WXMErrorStatusConfiguration.h
//  ModuleDebugging
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 wq. All rights reserved.
//

#ifndef WXMErrorStatusConfiguration_h
#define WXMErrorStatusConfiguration_h

#define WXM_ERGBColor(r, g, b) \
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define WXM_FixedWidth ([UIScreen mainScreen].bounds.size.width - 120)

/** 最小高度 */
#define WXM_MinH 60

/** tag */
#define WXM_ErrorSign 1020

/** 图片垂直偏移 */
#define WXM_Offset -35

/** 文字距离图片高度 */
#define WXM_MSGOffset 0

/**  */
#define WXM_OffsetRefresh -55

/**  */
#define WXM_RefreshMargin 30
#define WXM_RefreshCornerRadius 8
#define WXM_IMGSize CGSizeZero  /* CGSizeMake(10, 10) CGSizeZero */

#define WXM_BackgroundColor WXM_ERGBColor(240, 240, 240)
#define WXM_TextColor WXM_ERGBColor(55, 55, 55)
#define WXM_RefreshBgcolor WXM_ERGBColor(30, 144, 255)
#define WXM_RefreshTextcolor [UIColor whiteColor]

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


#endif /* WXMErrorStatusConfiguration_h */
