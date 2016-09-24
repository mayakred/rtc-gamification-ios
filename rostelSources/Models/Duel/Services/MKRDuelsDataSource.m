//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsDataSource.h"
#import "MKRDuelsCacheManager.h"
#import "MKRDuel.h"
#import "MKRDuelsService.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"


@implementation MKRDuelsDataSource {
    MKRDuelsCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRDuelsCacheManager *)newCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = newCacheManager;

    return self;
}

- (MKRDuel *)duelWithId:(NSNumber *)itemId {
    return [cacheManager duelWithId:itemId];
}

- (NSInteger)wonDuelsCount {
    NSInteger result = 0;
    NSNumber *curUserId = [MKRAppDataProvider shared].userService.currentUser.itemId;
    NSArray *duels = [cacheManager loadDuelsList];
    for (MKRDuel *duel in duels) {
        if ([duel.status isEqualToString:DUEL_STATUS_INITIATOR_WIN] && [curUserId isEqualToNumber:duel.initiator.itemId]) {
            result++;
        }
        if ([duel.status isEqualToString:DUEL_STATUS_WICTIM_WIN] && [curUserId isEqualToNumber:duel.victim.itemId]) {
            result++;
        }
    }
    return result;
}

- (NSInteger)drawDuelsCount {
    NSInteger result = 0;
    NSArray *duels = [cacheManager loadDuelsList];
    for (MKRDuel *duel in duels) {
        if ([duel.status isEqualToString:DUEL_STATUS_DRAW]) {
            result++;
        }
    }
    return result;
}


- (NSInteger)lostDuelsCount {
    NSInteger result = 0;
    NSNumber *curUserId = [MKRAppDataProvider shared].userService.currentUser.itemId;
    NSArray *duels = [cacheManager loadDuelsList];
    for (MKRDuel *duel in duels) {
        if ([duel.status isEqualToString:DUEL_STATUS_INITIATOR_WIN] && [curUserId isEqualToNumber:duel.victim.itemId]) {
            result++;
        }
        if ([duel.status isEqualToString:DUEL_STATUS_WICTIM_WIN] && [curUserId isEqualToNumber:duel.initiator.itemId]) {
            result++;
        }
    }
    return result;
}

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator {
    NSArray *duels = [cacheManager loadDuelsList];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *duelsCopy = comparator ? [duels sortedArrayUsingComparator:comparator] : duels;
    for (MKRDuel *duel in duelsCopy) {
        [result addObject:duel.itemId];
    }
    return [NSArray arrayWithArray:result];
}
@end