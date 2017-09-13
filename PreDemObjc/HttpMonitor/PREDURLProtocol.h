//
//  PREDURLProtocol.h
//  PreDemObjc
//
//  Created by WangSiyu on 21/02/2017.
//  Copyright © 2017 pre-engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PREDPersistence.h"

@interface PREDURLProtocol : NSURLProtocol

<<<<<<< HEAD
+ (void)setPersistence:(PREDPersistence *)persistence;
=======
@property (class, nonatomic, strong) PREDNetworkClient *networkClient;
>>>>>>> add breadscrumb

+ (void)enableHTTPMonitor;
+ (void)disableHTTMonitor;

@end
