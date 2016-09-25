//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRMetric;
@class MKRMetricsCacheManager;


@interface MKRMetricsDataSource : NSObject
- (instancetype)initWithCacheManager:(MKRMetricsCacheManager *)newCacheManager;

- (MKRMetric *)metricWithId:(NSNumber *)itemId;

- (NSArray *)metricsIdsWithComparator:(NSComparator)comparator;
@end