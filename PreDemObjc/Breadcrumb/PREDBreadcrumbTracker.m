//
//  PREDBreadcrumbTracker.m
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import "PREDBreadcrumbTracker.h"
#import "PREDSwizzle.h"
#import "PREDBreadcrumb.h"

@implementation PREDBreadcrumbTracker {
    PREDNetworkClient *_networkClient;
    NSMutableArray<PREDBreadcrumb *> *_breadcrumbs;
}

- (instancetype)initWithNetworkClient:(PREDNetworkClient *)networkClient {
    if (self = [super init]) {
        _networkClient = networkClient;
    }
    return self;
}

- (void)start {
    [self addEnabledCrumb];
    [self swizzleSendAction];
    [self swizzleViewDidAppear];
}

- (void)addEnabledCrumb {
    PREDBreadcrumb *breadcrumb = [[PREDBreadcrumb alloc]
                                  initWithType:@"debug"
                                  message:@"Breadcrumb start Tracking"
                                  data:nil];
    [_breadcrumbs addObject:breadcrumb];
}

- (void)swizzleSendAction {
    
}

- (void)swizzleViewDidAppear {
}

@end
