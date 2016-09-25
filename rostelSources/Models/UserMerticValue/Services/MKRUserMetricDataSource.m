//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserMetricDataSource.h"
#import "MKRUserMetricCacheManager.h"
#import "MKRUserMetricValue.h"


@implementation MKRUserMetricDataSource {
    MKRUserMetricCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRUserMetricCacheManager *)newCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = newCacheManager;

    return self;
}

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)itemId {
    return [cacheManager userMetricWithId:itemId];
}


- (NSArray *)usersMetricsIdsWithPerviySubview:(BOOL)perviySubiew andComparator:(NSComparator)comparator {
    NSArray *users = [cacheManager loadUsersMetrics];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *usersCopy = comparator ? [users sortedArrayUsingComparator:comparator] : users;
    for (MKRUserMetricValue *userMetric in usersCopy) {
        if (userMetric.isPerviySubview.boolValue == perviySubiew) {
            [result addObject:userMetric.itemId];
        }
    }
    return [NSArray arrayWithArray:result];
}

@end