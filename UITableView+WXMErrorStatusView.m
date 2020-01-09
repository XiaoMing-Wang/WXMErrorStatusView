//
//  UITableView+WXMErrorStatusView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/12/29.
//  Copyright © 2019 wxm. All rights reserved.
//
#import <SystemConfiguration/SCNetworkReachability.h>
#import "UITableView+WXMErrorStatusView.h"
#import "UIView+WXMErrorStatusView.h"
#import <objc/runtime.h>
#import <netinet/in.h>

static char firstLoad;
@implementation UITableView (WXMErrorStatusView)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData)
                          method2:@selector(we_reloadData)];
    
    /**  section */
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:)
                          method2:@selector(we_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:)
                          method2:@selector(we_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:)
                          method2:@selector(we_reloadSections:withRowAnimation:)];
    
    /** row */
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:)
                          method2:@selector(we_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:)
                          method2:@selector(we_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:)
                          method2:@selector(we_reloadRowsAtIndexPaths:withRowAnimation:)];
}

#pragma mark - Private Method (UITableView、UICollectionView有效)
- (NSInteger)totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections;
             section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }
    return totalCount;
}

/** 开始加载 */
- (void)startLoading {
    [self showErrorStatusViewWithType:WXMErrorStatusTypeRequestLoading];
}

/** 获取个数 */
- (void)getDataSources {
    NSInteger tableCount = self.totalDataCount;
    if (tableCount > 0) {
        [self hidenErrorStatusView];
    } else {
        BOOL network = self.internetStatusnetwork;
        BOOL fail = self.requestFail;
        if (network == NO) {
            [self showErrorStatusViewWithType:WXMErrorStatusTypeBadNetwork];
        } else if (network && !fail) {
            [self showErrorStatusViewWithType:WXMErrorStatusTypeNorecord];
        }  else if (network && fail) {
            [self showErrorStatusViewWithType:WXMErrorStatusTypeRequestFail];
        }
        self.requestFail = NO;
    }
}

- (void)we_reloadData {
    [self we_reloadData];
    if (self.automaticManagement) [self getDataSources];
}

/**  section */
- (void)we_insertSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_insertSections:sections withRowAnimation:animation];
    [self getDataSources];
}
- (void)we_deleteSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_deleteSections:sections withRowAnimation:animation];
    [self getDataSources];
}
- (void)we_reloadSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_reloadSections:sections withRowAnimation:animation];
    [self getDataSources];
}

/** row */
- (void)we_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataSources];
}

- (void)we_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataSources];
}

- (void)we_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation {
    [self we_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataSources];
}

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1),
                                   class_getInstanceMethod(self, method2));
}

- (void)setAutomaticManagement:(BOOL)automaticManagement {
    NSNumber *number = @(automaticManagement);
    SEL sel = @selector(automaticManagement);
    objc_setAssociatedObject(self, sel, number,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)automaticManagement {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setRequestFail:(BOOL)requestFail {
    NSNumber *number = @(requestFail);
    SEL sel = @selector(requestFail);
    objc_setAssociatedObject(self, sel, number,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)requestFail {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

/** 监听网络 */
- (BOOL)internetStatusnetwork {
    // Create zero addy
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    // Recover reachability flags
    // SCNetworkReachabilityFlags：保存返回的测试连接状态
    // 其中常用的状态有：
    // kSCNetworkReachabilityFlagsReachable：能够连接网络
    // kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
    // kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL,
    (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end

