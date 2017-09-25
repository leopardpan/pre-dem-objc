//
//  PREDPersistence.h
//  Pods
//
//  Created by 王思宇 on 14/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "PREDCrashMeta.h"
#import "PREDLagMeta.h"
#import "PREDLogMeta.h"
#import "PREDHTTPMonitorModel.h"
#import "PREDNetDiagResult.h"
#import "PREDAppInfo.h"

@interface PREDPersistence : NSObject

- (void)persistAppInfo:(PREDAppInfo *)appInfo;
- (void)persistCrashMeta:(PREDCrashMeta *)crashMeta;
- (void)persistLagMeta:(PREDLagMeta *)lagMeta;
- (void)persistLogMeta:(PREDLogMeta *)logMeta;
- (void)persistHttpMonitor:(PREDHTTPMonitorModel *)httpMonitor;
- (void)persistNetDiagResult:(PREDNetDiagResult *)netDiagResult;
- (void)persistCustomEventWithName:(NSString *)eventName events:(NSArray<NSDictionary<NSString *, NSString *> *>*)events;

- (NSString *)nextAppInfoPath;
- (NSString *)nextCrashMetaPath;
- (NSString *)nextLagMetaPath;
- (NSString *)nextLogMetaPath;
- (NSString *)nextHttpMonitorPath;
- (NSArray *)allHttpMonitorPaths;
- (NSString *)nextNetDiagPath;
- (NSString *)nextCustomEventsPath;

- (NSMutableDictionary *)getLogMeta:(NSString *)filePath error:(NSError **)error;
- (NSMutableDictionary *)getStoredMeta:(NSString *)filePath error:(NSError **)error;
- (void)purgeFile:(NSString *)filePath;
- (void)purgeAllAppInfo;
- (void)purgeFiles:(NSArray<NSString *> *)filePaths;

@end
