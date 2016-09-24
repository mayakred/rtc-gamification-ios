//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsDataSource.h"
#import "MKRDuelsCacheManager.h"
#import "MKRDuel.h"


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