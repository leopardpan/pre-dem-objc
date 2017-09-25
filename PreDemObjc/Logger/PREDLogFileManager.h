//
//  PREDLogFileManager.h
//  Pods
//
//  Created by 王思宇 on 05/09/2017.
//
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@class PREDLogFileManager;

@protocol PREDLogFileManagerDelegate <NSObject>

- (void)logFileManager:(PREDLogFileManager *)logFileManager willCreatedNewLogFile:(NSString *)logFilePath;

@end

@interface PREDLogFileManager : DDLogFileManagerDefault

@property (nonatomic, weak) id<PREDLogFileManagerDelegate> delegate;

@end
