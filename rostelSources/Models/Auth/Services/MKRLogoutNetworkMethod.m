//
// Created by Anton Zlotnikov on 04.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRLogoutNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRResponseInfo.h"
#import "MKRConsts.h"
#import "NSError+Extension.h"


@implementation MKRLogoutNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_AUTH_LOGOUT andMethod:RKRequestMethodPOST andMapping:nil];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)logoutWithSuccess:(void (^)())successBlock failure:(void (^)(NSError *error, NSArray *serverErrors))failureBlock {
    [[RKObjectManager sharedManager] postObject:nil path:API_AUTH_LOGOUT parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self basicEmptySuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
    }];
}

@end