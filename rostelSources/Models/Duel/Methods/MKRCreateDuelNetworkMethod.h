//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"

@class MKRDuel;


@interface MKRCreateDuelNetworkMethod : MKRBaseNetworkMethod
- (void)createDuelWithWictimId:(NSNumber *)victimId andMetricCode:(NSString *)metricCode andEndTime:(NSNumber *)endTime success:(void (^)(MKRDuel *duel))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end