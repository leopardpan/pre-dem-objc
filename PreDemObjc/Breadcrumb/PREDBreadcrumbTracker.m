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
    NSRecursiveLock *_lock;
}

- (instancetype)initWithNetworkClient:(PREDNetworkClient *)networkClient {
    if (self = [super init]) {
        _networkClient = networkClient;
        _lock = [NSRecursiveLock new];
    }
    return self;
}

- (void)start {
    [self addEnabledCrumb];
    [self swizzleSendAction];
    [self swizzleViewDidAppear];
}

- (void)addBreadScrumb:(PREDBreadcrumb *)breadscrumb {
    [_lock lock];
    [_breadcrumbs addObject:breadscrumb];
    [_lock unlock];
}

- (void)addEnabledCrumb {
    PREDBreadcrumb *breadcrumb = [[PREDBreadcrumb alloc]
                                  initWithCategory:@"started"
                                  Type:@"debug"
                                  message:@"Breadcrumb Tracking"
                                  data:nil];
    [_breadcrumbs addObject:breadcrumb];
}

- (void)swizzleSendAction {
    static const void *swizzleSendActionKey = &swizzleSendActionKey;
    //    - (BOOL)sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event;
    SEL selector = NSSelectorFromString(@"sendAction:to:from:forEvent:");
    PREDSwizzleInstanceMethod(UIApplication.class,
                              selector,
                              PREDSWReturnType(BOOL),
                              PREDSWArguments(SEL action, id target, id sender, UIEvent * event),
                              PREDSWReplacement({
        NSDictionary *data = [NSDictionary new];
        for (UITouch *touch in event.allTouches) {
            if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
                data = @{@"view": [NSString stringWithFormat:@"%@", touch.view]};
            }
        }
        PREDBreadcrumb *breadcrumb = [[PREDBreadcrumb alloc]
                                      initWithCategory:@"touch"
                                      Type:@"user"
                                      message:[NSString stringWithFormat:@"%s", sel_getName(action)]
                                      data:data];
        [_lock lock];
        [_breadcrumbs addObject:breadcrumb];
        [_lock unlock];
        return PREDSWCallOriginal(action, target, sender, event);
    }), PREDSwizzleModeOncePerClassAndSuperclasses, swizzleSendActionKey);
}

- (void)swizzleViewDidAppear {
    static const void *swizzleViewDidAppearKey = &swizzleViewDidAppearKey;
    // -(void)viewDidAppear:(BOOL)animated
    SEL selector = NSSelectorFromString(@"viewDidAppear:");
    PREDSwizzleInstanceMethod(UIViewController.class,
                              selector,
                              PREDSWReturnType(void),
                              PREDSWArguments(BOOL animated),
                              PREDSWReplacement({
        
        PREDBreadcrumb *breadcrumb = [[PREDBreadcrumb alloc]
                                      initWithCategory:@"UIViewController"
                                      Type:@"navigation"
                                      message:@"viewDidAppear"
                                      data:@{
                                             @"controller": [NSString stringWithFormat:@"%@", self]
                                             }];
        [_lock lock];
        [_breadcrumbs addObject:breadcrumb];
        [_lock unlock];
        PREDSWCallOriginal(animated);
    }), PREDSwizzleModeOncePerClassAndSuperclasses, swizzleViewDidAppearKey);
}

@end
