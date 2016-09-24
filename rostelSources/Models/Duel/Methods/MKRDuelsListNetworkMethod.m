//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsListNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRDuel.h"


@implementation MKRDuelsListNetworkMethod {

}


- (instancetype)init {
    self = [super initWithUrl:API_DUELS_LIST andMethod:RKRequestMethodGET andMapping:[MKRDuel mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)duelsListWithSuccess:(void (^)(NSArray *usersList))successBlock
                     failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObjectsAtPath:self.url parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}


@end