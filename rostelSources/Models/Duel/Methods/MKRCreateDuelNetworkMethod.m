//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRCreateDuelNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRDuel.h"


@implementation MKRCreateDuelNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_CREATE_DUEL andMethod:RKRequestMethodPOST andMapping:[MKRDuel mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)createDuelWithWictimId:(NSNumber *)victimId andMetricCode:(NSString *)metricCode andEndTime:(NSNumber *)endTime success:(void (^)(MKRDuel *duel))successBlock
                     failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] postObject:nil path:self.url parameters:@{
                    @"victim_id" : victimId,
                    @"metric_code" : metricCode,
                    @"end_at" : endTime,
            }
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}


@end