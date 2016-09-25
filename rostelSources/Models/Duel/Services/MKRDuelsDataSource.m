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
//    NSNumber *curUserId = @1;
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
//    NSNumber *curUserId = @1;
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

- (NSNumber *)getOrderNumberFromDuel:(MKRDuel *)duel {
    NSNumber *userId = [MKRAppDataProvider shared].userService.currentUser.itemId;
    if ([duel.status isEqualToString:DUEL_STATUS_WAITING_VICTIM] && [duel.victim.itemId isEqualToNumber:userId]) {
        return @1;
    } else if ([duel.status isEqualToString:DUEL_STATUS_IN_PROGRESS]) {
        return @2;
    } else if ([duel.status isEqualToString:DUEL_STATUS_WAITING_VICTIM]) {
        return @3;
    } else if ([duel.status isEqualToString:DUEL_STATUS_WICTIM_WIN]) {
        return @4;
    } else if ([duel.status isEqualToString:DUEL_STATUS_DRAW]) {
        return @5;
    } else if ([duel.status isEqualToString:DUEL_STATUS_INITIATOR_WIN]) {
        return @6;
    } else if ([duel.status isEqualToString:DUEL_STATUS_REJECTED_BY_VICTIM]) {
        return @7;
    }
    return @8;
}

- (NSArray *)duelsIdsWithComparator:(NSComparator)comparator {
    NSArray *duels = [cacheManager loadDuelsList];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *duelsCopy = comparator ? [duels sortedArrayUsingComparator:comparator] : duels;
    duelsCopy = [duelsCopy sortedArrayUsingComparator:^NSComparisonResult(MKRDuel *obj1, MKRDuel *obj2) {
        NSNumber *order1 = [self getOrderNumberFromDuel:obj1];
        NSNumber *order2 = [self getOrderNumberFromDuel:obj2];
        
        return [order1 compare:order2];
    }];
    for (MKRDuel *duel in duelsCopy) {
        [result addObject:duel.itemId];
    }
    return [NSArray arrayWithArray:result];
}
@end
