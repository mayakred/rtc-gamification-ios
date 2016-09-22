//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"

@class MKRFullUser;


@interface MKRGetUserNetworkMethod : MKRBaseNetworkMethod
- (void)currentUserWithId:(NSNumber *)userId success:(void (^)(MKRFullUser *user))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end