//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStatsNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRStrangeObject.h"


@implementation MKRStatsNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_STATISTIC andMethod:RKRequestMethodGET andMapping:[MKRStrangeObject mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)statsWithUserId:(NSNumber *)userId success:(void (^)(NSArray *statsList))successBlock
                        failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:API_STATISTIC_PATTERN, userId] parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end