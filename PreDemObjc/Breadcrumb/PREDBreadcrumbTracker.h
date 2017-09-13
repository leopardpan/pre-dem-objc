//
//  PREDBreadcrumbTracker.h
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "PREDNetworkClient.h"
#import "PREDBreadcrumb.h"

@interface PREDBreadcrumbTracker : NSObject

- (instancetype)initWithNetworkClient:(PREDNetworkClient *)networkClient;
- (void)start;
- (void)addBreadScrumb:(PREDBreadcrumb *)breadscrumb;

@end
