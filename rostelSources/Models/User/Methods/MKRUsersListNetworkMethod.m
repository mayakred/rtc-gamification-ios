//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUsersListNetworkMethod.h"
#import "MKRUser.h"
#import "MKRNetworkConfigManager.h"


@implementation MKRUsersListNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_USERS_LIST andMethod:RKRequestMethodGET andMapping:[MKRUser mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)usersListWithSuccess:(void (^)(NSArray *usersList))successBlock
                      failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] postObject:nil path:self.url parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}

@end