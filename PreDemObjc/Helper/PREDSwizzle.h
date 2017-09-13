//
//  PREDSwizzle.h
//  Pods
//
//  Created by 王思宇 on 13/09/2017.
//
//

#import <Foundation/Foundation.h>

/**
 A function pointer to the original implementation of the swizzled method.
 */
typedef void (*PREDSwizzleOriginalIMP)(void /* id, SEL, ... */);

/**
 PREDSwizzleInfo is used in the new implementation block to get and call original implementation of the swizzled method.
 */
@interface PREDSwizzleInfo : NSObject

/**
 Returns the original implementation of the swizzled method.
 
 It is actually either an original implementation if the swizzled class implements the method itself; or a super implementation fetched from one of the superclasses.
 
 @note You must always cast returned implementation to the appropriate function pointer when calling.
 
 @return A function pointer to the original implementation of the swizzled method.
 */
- (PREDSwizzleOriginalIMP)getOriginalImplementation;

/// The selector of the swizzled method.
@property(nonatomic, readonly) SEL selector;

@end

typedef id (^PREDSwizzleImpFactoryBlock)(PREDSwizzleInfo *swizzleInfo);

typedef NS_ENUM(NSUInteger, PREDSwizzleMode) {
    /// PREDSwizzleModeAlways always does swizzling.
    PREDSwizzleModeAlways = 0,
    /// PREDSwizzleModeOncePerClass does not do swizzling if the same class has been swizzled earlier with the same key.
    PREDSwizzleModeOncePerClass = 1,
    /// PREDSwizzleModeOncePerClassAndSuperclasses does not do swizzling if the same class or one of its superclasses have been swizzled earlier with the same key.
    /// @note There is no guarantee that your implementation will be called only once per method call. If the order of swizzling is: first inherited class, second superclass, then both swizzlings will be done and the new implementation will be called twice.
    PREDSwizzleModeOncePerClassAndSuperclasses = 2
};

@interface PREDSwizzle : NSObject

+ (void)swizzleClassMethod:(SEL)selector
                   inClass:(Class)classToSwizzle
             newImpFactory:(PREDSwizzleImpFactoryBlock)factoryBlock;

+ (BOOL)swizzleInstanceMethod:(SEL)selector
                      inClass:(Class)classToSwizzle
                newImpFactory:(PREDSwizzleImpFactoryBlock)factoryBlock
                         mode:(PREDSwizzleMode)mode
                          key:(const void *)key;

@end
