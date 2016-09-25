//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsListNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRMetric.h"


@implementation MKRMetricsListNetworkMethod {

}


- (instancetype)init {
    self = [super initWithUrl:API_METRICS_LIST andMethod:RKRequestMethodGET andMapping:[MKRMetric mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)metricsListWithSuccess:(void (^)(NSArray *metricsList))successBlock
                     failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObjectsAtPath:self.url parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end