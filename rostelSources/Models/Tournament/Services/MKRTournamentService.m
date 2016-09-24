//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRTournamentService.h"
#import "MKRTournamentCacheManager.h"
#import "MKRTournamentListNetworkMethod.h"
#import "MKRTournament.h"
#import "MKRErrorContainer.h"


@implementation MKRTournamentService {
    MKRTournamentCacheManager *cacheManager;
    MKRTournamentListNetworkMethod *tournamentListNetworkMethod;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    cacheManager = [[MKRTournamentCacheManager alloc] init];
    tournamentListNetworkMethod = [[MKRTournamentListNetworkMethod alloc] init];
    return self;
}

- (void)loadTournamentsForUserWithId:(NSNumber *)userId success:(void (^)(MKRTournament *personalTournament, MKRTournament *totalTournament))successBlock
                             failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSParameterAssert(userId);
    NSLog(@"Start loading user with id %@", userId);
    [tournamentListNetworkMethod tournamentsListWithUserId:userId success:^(NSArray *tournamentList) {
        [cacheManager saveTournamentsList:tournamentList];
        MKRTournament *personalTournament = [cacheManager tournamentWithType:TOURNAMENT_TYPE_INDIVIDUAL];
        MKRTournament *totalTournament = [cacheManager tournamentWithType:TOURNAMENT_TYPE_TOTAL];
        if (successBlock) {
            successBlock(personalTournament, totalTournament);
        }
    } failure:^(NSError *error, NSArray *serverErrors) {
        if (failureBlock) {
            failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
        }
    }];
}

@end