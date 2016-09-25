//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsDataSource.h"
#import "MKRMetricsCacheManager.h"
#import "MKRMetric.h"


@implementation MKRMetricsDataSource {
    MKRMetricsCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRMetricsCacheManager *)newCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = newCacheManager;

    return self;
}

- (MKRMetric *)metricWithId:(NSNumber *)itemId {
    return [cacheManager metricWithId:itemId];
}

- (NSArray *)metricsIdsWithComparator:(NSComparator)comparator {
    NSArray *metrics = [cacheManager loadMetrics];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *metricsCopy = comparator ? [metrics sortedArrayUsingComparator:comparator] : metrics;
    for (MKRMetric *metric in metricsCopy) {
        if (metric.availableForDuel.boolValue) {
            [result addObject:metric.itemId];
        }
    }
    return [NSArray arrayWithArray:result];
}

@end