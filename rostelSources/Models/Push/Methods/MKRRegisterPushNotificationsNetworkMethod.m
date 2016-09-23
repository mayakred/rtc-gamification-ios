//
// Created by Anton Zlotnikov on 31.05.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRRegisterPushNotificationsNetworkMethod.h"
#import "MKRNetworkConfigManager.h"

static NSString *const kMKRPlayerIdKey = @"player_id";

@implementation MKRRegisterPushNotificationsNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_REGISTER_PLAYER_ID andMethod:RKRequestMethodPOST andMapping:nil];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)registerWithPlayerId:(NSString *)playerId
                  success:(void (^)())successBlock failure:(MKRFailBlockHandler)failureBlock {
    NSParameterAssert(playerId);

    [[RKObjectManager sharedManager] postObject:nil path:API_REGISTER_PLAYER_ID parameters:@{
                    kMKRPlayerIdKey : playerId
            }
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self basicEmptySuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
    }                                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
    }];
}


@end