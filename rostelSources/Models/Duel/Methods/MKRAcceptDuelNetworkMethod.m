//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRAcceptDuelNetworkMethod.h"
#import "MKRNetworkConfigManager.h"


@implementation MKRAcceptDuelNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_ACCEPT_DUEL andMethod:RKRequestMethodPOST andMapping:nil];
    if (!self) {
        return nil;
    }

    return self;
}


- (void)acceptDuelWithId:(NSNumber *)duelId success:(void (^)())successBlock
                  failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] postObject:nil path:[NSString stringWithFormat:API_ACCEPT_DUEL_PATTERN, duelId] parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           [self basicEmptySuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end
