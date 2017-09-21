//
//  PREDBreadcrumbTracker.h
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "PREDPersistence.h"
#import "PREDBreadcrumb.h"

@interface PREDBreadcrumbTracker : NSObject

- (instancetype)initWithPersistence:(PREDPersistence *)persistence;
- (void)start;
- (void)addBreadcrumb:(PREDBreadcrumb *)breadscrumb;

@end
