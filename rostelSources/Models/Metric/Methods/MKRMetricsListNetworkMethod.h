//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseNetworkMethod.h"


@interface MKRMetricsListNetworkMethod : MKRBaseNetworkMethod
- (void)metricsListWithSuccess:(void (^)(NSArray *metricsList))successBlock failure:(MKRFailBlockHandler)failureBlock;
@end