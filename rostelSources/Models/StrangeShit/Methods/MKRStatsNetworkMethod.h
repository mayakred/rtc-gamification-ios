//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRStatsNetworkMethod : MKRBaseNetworkMethod
- (void)statsWithUserId:(NSNumber *)userId success:(void (^)(NSArray *statsList))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end