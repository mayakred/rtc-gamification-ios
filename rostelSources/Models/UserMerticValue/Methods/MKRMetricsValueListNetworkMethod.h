//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRMetricsValueListNetworkMethod : MKRBaseNetworkMethod

- (void)userMetricsListWithMetricCode:(NSString *)mCode andPerviySubview:(BOOL)perviySubview success:(void (^)(NSArray *metricsList))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end