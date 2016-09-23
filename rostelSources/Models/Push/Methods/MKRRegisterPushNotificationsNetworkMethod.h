//
// Created by Anton Zlotnikov on 31.05.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRRegisterPushNotificationsNetworkMethod : MKRBaseNetworkMethod
- (void)registerWithPlayerId:(NSString *)playerId success:(void (^)())successBlock failure:(MKRFailBlockHandler)failureBlock;
@end