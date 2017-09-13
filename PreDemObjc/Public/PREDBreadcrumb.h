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
 * Category of bookmark, can be any string
 */
@property(nonatomic, copy) NSString *_Nonnull category;


/**
 * Type of breadcrumb, can be e.g.: http, empty, user, navigation
 * This will be used as icon of the breadcrumb
 */
@property(nonatomic, copy) NSString *_Nullable type;

/**
 * Message for the breadcrumb
 */
@property(nonatomic, copy) NSString *_Nullable message;

/**
 * Arbitrary additional data that will be sent with the breadcrumb
 */
@property(nonatomic, strong) NSDictionary<NSString *, id> *_Nullable data;

- (instancetype _Nullable)initWithCategory:(NSString *_Nonnull)category
                                      Type:(NSString *_Nullable)type
                                   message:(NSString *_Nullable)message
                                      data:(NSDictionary<NSString *, id> *_Nullable)data;

@end
