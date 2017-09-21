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
    PREDPersistence *_persistence;
}

- (instancetype)initWithPersistence:(PREDPersistence *)persistence {
    if (self = [super init]) {
        _persistence = persistence;
    }
    return self;
}

- (void)start {
    [self addEnabledCrumb];
    [self swizzleSendAction];
    [self swizzleViewDidAppear];
}

- (void)addBreadcrumb:(PREDBreadcrumb *)breadcrumb {
    [_persistence persistBreadcrumb:breadcrumb];
}

- (void)addEnabledCrumb {
    PREDBreadcrumb *breadcrumb = [[PREDBreadcrumb alloc]
                                  initWithCategory:@"started"
                                  Type:@"debug"
                                  message:@"Breadcrumb Tracking"
                                  data:nil];
    [_persistence persistBreadcrumb:breadcrumb];
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
        [_persistence persistBreadcrumb:breadcrumb];
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
        [_persistence persistBreadcrumb:breadcrumb];
        PREDSWCallOriginal(animated);
    }), PREDSwizzleModeOncePerClassAndSuperclasses, swizzleViewDidAppearKey);
}

@end
