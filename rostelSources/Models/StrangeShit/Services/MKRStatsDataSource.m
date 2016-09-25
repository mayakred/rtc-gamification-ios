//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStatsDataSource.h"
#import "MKRStatsCacheManager.h"
#import "MKRStrangeObject.h"


@implementation MKRStatsDataSource {
    MKRStatsCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRStatsCacheManager *)newCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = newCacheManager;

    return self;
}

- (MKRStrangeObject *)statWithId:(NSNumber *)itemId {
    return [cacheManager statWithId:itemId];
}

- (NSArray *)statsIdsWithUserId:(NSNumber *)userId andIsIndividual:(BOOL)ind andComparator:(NSComparator)comparator {
    NSArray *stats = [cacheManager loadStats];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *statsCopy = comparator ? [stats sortedArrayUsingComparator:comparator] : stats;
    for (MKRStrangeObject *stat in statsCopy) {
        if ([stat.userId isEqualToNumber:userId] && stat.isPerviySubview.boolValue == ind) {
            [result addObject:stat.itemId];
        }
    }
    return [NSArray arrayWithArray:result];
}

@end
