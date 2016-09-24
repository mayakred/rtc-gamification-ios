//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRTournament;
@class MKRErrorContainer;

#define TOURNAMENT_TYPE_INDIVIDUAL @"tournament_type.individual"
#define TOURNAMENT_TYPE_TOTAL @"tournament_type.total"

@interface MKRTournamentService : NSObject

- (void)loadTournamentsForUserWithId:(NSNumber *)userId success:(void (^)(MKRTournament *personalTournament, MKRTournament *totalTournament))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;
@end