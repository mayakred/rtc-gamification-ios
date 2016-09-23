//
// Created by Anton Zlotnikov on 31.05.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;


@interface MKRPushService : NSObject
- (void)registerWithPlayerId:(NSString *)playerId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)unregisterForPushNotifications;

- (void)registerForPushNotifications;
@end