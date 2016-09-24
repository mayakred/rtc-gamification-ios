//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRTournamentListNetworkMethod.h"
#import "MKRNetworkConfigManager.h"
#import "MKRTournament.h"


@implementation MKRTournamentListNetworkMethod {

}

- (instancetype)init {
    self = [super initWithUrl:API_TOURNAMENTS_LIST andMethod:RKRequestMethodGET andMapping:[MKRTournament mapping]];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)tournamentsListWithUserId:(NSNumber *)userId success:(void (^)(NSArray *usersList))successBlock
                     failure:(MKRFailBlockHandler)failureBlock {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:API_TOURNAMENTS_LIST_PATTERN, userId] parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self basicSuccessBlockHandlerWithOperation:operation andMappingResult:mappingResult success:successBlock failure:failureBlock];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                [self basicFailureBlockHandlerWithOperation:operation andError:error failure:failureBlock];
            }];
}


@end