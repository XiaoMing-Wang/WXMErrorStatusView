//
//  WXMStatusView.m
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//
#define WXM_SWidth [UIScreen mainScreen].bounds.size.width
#define WXM_SHeight [UIScreen mainScreen].bounds.size.height
#import "WXMErrorStatusView.h"

@interface WXMErrorStatusView ()
@property(nonatomic, strong) UIActivityIndicatorView *refrshIndicator;
@end

@implementation WXMErrorStatusView

/** 图片 */
- (UIImage *)currentImage {
    NSString * imageName = @"";
    switch (self.errorType) {
        case WXMErrorStatusTypeNormal:imageName = @""; break;
        case WXMErrorStatusTypeBadNetwork:imageName = @"refreshtableview_nonetwork"; break;
        case WXMErrorStatusTypeNorecord: imageName = @"refreshtableview_defaultnodata";  break;
        case WXMErrorStatusTypeRequestFail: imageName = @"refreshtableview_requesterror";  break;
        default: break;
    }
    return [UIImage imageNamed:imageName] ?: nil;
}

/** 提示内容 */
- (NSString *)currentMessage {
    NSString * messsage = @"";
    switch (self.errorType) {
        case WXMErrorStatusTypeNormal:messsage = @""; break;
        case WXMErrorStatusTypeBadNetwork:messsage = @"网络异常"; break;
        case WXMErrorStatusTypeNorecord: messsage = @"暂无更多记录";  break;
        case WXMErrorStatusTypeRequestFail: messsage = @"数据加载失败"; break;
        default: break;
    }
    return messsage;
}

+ (WXMErrorStatusView *)errorsViewWithType:(WXMErrorStatusType)type {
    return [self errorsViewWithType:type interfaceType:WXMErrorFaceTypeDefault];
}

+ (WXMErrorStatusView *)errorsViewWithType:(WXMErrorStatusType)type
                             interfaceType:(WXMErrorStatusInterfaceType)interfaceType {
    if (type == WXMErrorStatusTypeNormal) return nil;
    WXMErrorStatusView *statusView = [WXMErrorStatusView new];
    statusView.errorType = type;
    statusView.interfaceType = interfaceType;
    statusView.tag = WXM_ErrorSign;
    [statusView initializeInterface];
    return statusView;
}

- (void)initializeInterface {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = WXM_BackgroundColor;
    
    if (self.errorType == WXMErrorStatusTypeRequestLoading) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_indicatorView startAnimating];
        [self addSubview:_indicatorView];
        [self modifyCoordinate];
        
    } else {
        
        UIImage *image = self.currentImage;
        CGFloat oldWidth = image.size.width;
        if (oldWidth > (WXM_SWidth - 120)) oldWidth = WXM_SWidth - 120;
        CGFloat imgHeight = (image.size.height / image.size.width) *oldWidth;
        
        /** 自定义图片大小 */
        if (CGSizeEqualToSize(WXM_IMGSize, CGSizeZero) == NO) {
            oldWidth = WXM_IMGSize.width;
            imgHeight = WXM_IMGSize.height;
        }
        
        _erroeImgVC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,oldWidth,imgHeight)];
        _erroeImgVC.image = image;
        
        _errorMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _errorMsg.textAlignment = NSTextAlignmentCenter;
        _errorMsg.text = self.currentMessage;
        _errorMsg.font = [UIFont systemFontOfSize:15];
        _errorMsg.textColor = WXM_TextColor;
        _errorMsg.numberOfLines = 1;
        
        SEL sel = @selector(touchUpInside);
        _refreshControl = [[UIButton alloc] init];
        _refreshControl.frame = CGRectMake(0, 0, 0, 30);
        [_refreshControl setBackgroundColor:WXM_RefreshBgcolor];
        [_refreshControl setTitleColor:WXM_RefreshTextcolor forState:UIControlStateNormal];
        [_refreshControl setTitle:WXM_RefreshText forState:UIControlStateNormal];
        _refreshControl.layer.cornerRadius = WXM_RefreshCornerRadius;
        _refreshControl.layer.borderColor = WXM_RefreshTextcolor.CGColor;
        _refreshControl.layer.borderWidth = 0.5;
        _refreshControl.titleLabel.font = [UIFont systemFontOfSize:12];
        _refreshControl.hidden = (_interfaceType != WXMErrorFaceTypeRefresh);
        [_refreshControl addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        
        _refrshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
        _refrshIndicator.hidesWhenStopped = YES;
        _refrshIndicator.hidden = YES;
        _refrshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        [self addSubview:_erroeImgVC];
        [self addSubview:_errorMsg];
        [self addSubview:_refreshControl];
        [self addSubview:_refrshIndicator];
        [self modifyCoordinate];
    }
}

/** 更新frame */
- (void)modifyCoordinate {
    if (!self.superview) return;
    CGFloat superWidth = self.superview.frame.size.width;
    CGFloat superHeight = self.superview.frame.size.height;
    superHeight = MIN(superHeight, WXM_SHeight);
       
    if (self.errorType == WXMErrorStatusTypeRequestLoading) {
        self.frame = CGRectMake(0, 0, superWidth, superHeight);
        self.indicatorView.center = CGPointMake(superWidth / 2, superHeight / 2);
        [self.indicatorView startAnimating];
    } else if (self.errorType == WXMErrorStatusTypeNormal) {
    } else {
        [_errorMsg sizeToFit];
        _erroeImgVC.center = CGPointMake(superWidth / 2, _erroeImgVC.center.y);
        _errorMsg.center = CGPointMake(superWidth / 2, _errorMsg.center.y);
        _refrshIndicator.center = CGPointMake(superWidth / 2, 0);
        
        BOOL refresh = (self.interfaceType == WXMErrorFaceTypeRefresh);
        CGFloat refresH = refresh ? 45 + 15 : 0;
        CGFloat imageH = _erroeImgVC.frame.size.height;
        CGFloat msgH = _errorMsg.frame.size.height;
        
        CGFloat minH = WXM_MinH + imageH + msgH + refresH;
        CGFloat realH = MAX(minH, superHeight);
        
        CGFloat blank = realH - imageH - msgH - refresH;
        CGFloat top = (blank - 10) / 2.0 + WXM_Offset;
        if (_interfaceType == WXMErrorFaceTypeRefresh) {
            top = (blank - 10) / 2.0 + WXM_OffsetRefresh;
        }
        CGRect imgFrame = _erroeImgVC.frame;
        CGRect msgFrame = _errorMsg.frame;
        CGRect refreshFrame = _refreshControl.frame;
        CGRect icatorFrame = _refrshIndicator.frame;
        
        imgFrame.origin.y = top;
        msgFrame.origin.y = top + imgFrame.size.height;
        refreshFrame.origin.y = msgFrame.origin.y + msgFrame.size.height + 18;
        refreshFrame.origin.x = (superWidth - WXM_RefreshWidth) / 2.0;
        refreshFrame.size.width = WXM_RefreshWidth;
        icatorFrame.origin.y = refreshFrame.origin.y;
        
        _erroeImgVC.frame = imgFrame;
        _errorMsg.frame = msgFrame;
        if (refresh) _refreshControl.frame = refreshFrame;
        if (_refrshIndicator) _refrshIndicator.frame = icatorFrame;
        self.frame = CGRectMake(0, 0, superWidth, realH);
    }
}

/** 刷新开始 */
- (void)refreshControlStartAnimation {
    if (self.interfaceType == WXMErrorFaceTypeDefault) {
        [_refrshIndicator startAnimating];
        _refrshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_refrshIndicator];
        
    } else if (self.interfaceType == WXMErrorFaceTypeRefresh) {
               
        _refreshControl.hidden = YES;
        [_refrshIndicator startAnimating];
        _refrshIndicator.center = _refreshControl.center;
        [self addSubview:_refrshIndicator];
    }
}

/** 结束刷新 */
- (void)refreshControlStopAnimation:(BOOL)success {
    if (success) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) { [self removeFromSuperview]; }];
    } else {
        _refreshControl.hidden = NO;
        [_refrshIndicator removeFromSuperview];
    }
}

/** 全屏刷新 */
- (void)setFullScreenRefresh:(BOOL)fullScreenRefresh {
    _fullScreenRefresh = fullScreenRefresh;
    if (self.interfaceType == WXMErrorFaceTypeRefresh) return;
    SEL sel = @selector(touchUpInside);
    if (fullScreenRefresh) {
        [self addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self removeTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addTarget:(id)target selector:(SEL)sel {
    if (self.interfaceType == WXMErrorFaceTypeDefault) {
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    } else if (self.interfaceType == WXMErrorFaceTypeRefresh) {
        [_refreshControl addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)touchUpInside {
    if (self.callBack) self.callBack();
    [self refreshControlStartAnimation];
}

/** 设置类型 */
- (void)setErrorType:(WXMErrorStatusType)errorType {
    _errorType = errorType;
    _erroeImgVC.image = self.currentImage;
    _errorMsg.text = self.currentMessage;
    if (errorType == WXMErrorStatusTypeNormal) {
        [self removeFromSuperview];
        return;
    }
    [self modifyCoordinate];
}

+ (CGFloat)minHeightWithType:(WXMErrorStatusInterfaceType)interfaceType {
    BOOL refresh = (interfaceType == WXMErrorFaceTypeRefresh);
    CGFloat incremental = refresh ? 60 : 0;
    if (CGSizeEqualToSize(WXM_IMGSize, CGSizeZero) == NO) {
        return WXM_MinH + WXM_IMGSize.height + 20 + incremental;
    }
    return WXM_MinH + ((WXM_SWidth - 120) * 1.1) + 20 + incremental;
}

- (void)didMoveToSuperview {
    if (self.superview) [self modifyCoordinate];
}
@end
