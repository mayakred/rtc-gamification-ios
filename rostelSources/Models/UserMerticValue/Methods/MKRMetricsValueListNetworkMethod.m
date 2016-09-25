//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsValueListNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRUserMetricValue.h"


@implementation MKRMetricsValueListNetworkMethod {

}


- (instancetype)init {
    self = [super initWithUrl:API_USER_METRICS_VALUE_LIST andMethod:RKRequestMethodGET andMapping:[MKRUserMetricValue mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)userMetricsListWithMetricCode:(NSString *)mCode andPerviySubview:(BOOL)perviySubview success:(void (^)(NSArray *metricsList))successBlock
                       failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:API_USER_METRICS_VALUE_LIST_PATTERN, mCode] parameters:@{
                    @"is_perviy_subview" : @(perviySubview)
            } success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}


@end