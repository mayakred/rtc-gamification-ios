//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"

@class MKRFullUser;

@interface MKRGetCurrentUserNetworkMethod : MKRBaseNetworkMethod
- (void)currentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end