//
//  PREDBreadcrumb.h
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import <Foundation/Foundation.h>

@interface PREDBreadcrumb : NSObject

/**
 * SessionId identify a single run of the application, it will change when the application is restarted
 */
@property(nonatomic, strong, nonnull, readonly) NSString *sessionId;

/**
 * Category of bookmark, can be any string
 */
@property(nonatomic, copy, nonnull) NSString *category;


/**
 * Type of breadcrumb, can be e.g.: http, empty, user, navigation
 * This will be used as icon of the breadcrumb
 */
@property(nonatomic, copy, nullable) NSString *type;

/**
 * Message for the breadcrumb
 */
@property(nonatomic, copy, nullable) NSString *message;

/**
 * Arbitrary additional data that will be sent with the breadcrumb
 */
@property(nonatomic, strong, nullable) NSDictionary<NSString *, id> *data;

- (instancetype _Nullable)initWithCategory:(NSString *_Nonnull)category
                                      Type:(NSString *_Nullable)type
                                   message:(NSString *_Nullable)message
                                      data:(NSDictionary<NSString *, id> *_Nullable)data;

@end
