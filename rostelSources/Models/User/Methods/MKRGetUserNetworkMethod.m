//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRGetUserNetworkMethod.h"
#import "MKRFullUser.h"
#import "MKRNetworkConfigManager.h"


@implementation MKRGetUserNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_GET_USER andMethod:RKRequestMethodGET andMapping:[MKRFullUser mapping]];
    if (!self) {
        return nil;
    }

    return self;
}


- (void)currentUserWithId:(NSNumber *)userId success:(void (^)(MKRFullUser *user))successBlock
                  failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:API_GET_USER_PATTERN, userId] parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end