//
//  SentryBreadcrumb.m
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import "PREDBreadcrumb.h"

@interface PREDBreadcrumb ()

/**
 * NSDate when the breadcrumb happened
 */
@property(nonatomic, strong) NSDate *timestamp;

@end

@implementation PREDBreadcrumb

- (instancetype)initWithType:(NSString *)type
                     message:(NSString *)message
                        data:(NSDictionary<NSString *, id> *)data {
    if (self = [self init]) {
        _type = type?:_type;
        _message = message?:_message;
        _data = data;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _timestamp = [NSDate date];
    }
    return self;
}

@end
