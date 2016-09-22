//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRGetCurrentUserNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRFullUser.h"


@implementation MKRGetCurrentUserNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_CURRENT_USER andMethod:RKRequestMethodGET andMapping:[MKRFullUser mapping]];
    if (!self) {
        return nil;
    }

    return self;
}


- (void)currentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock
                   failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObject:nil path:self.url parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                       } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end