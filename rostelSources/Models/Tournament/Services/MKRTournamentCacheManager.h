//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRTournament;


@interface MKRTournamentCacheManager : MKRBaseCacheManager

- (void)saveTournamentsList:(NSArray *)toursList;

- (MKRTournament *)tournamentWithType:(NSString *)tourType;

- (void)clearAllCache;
@end