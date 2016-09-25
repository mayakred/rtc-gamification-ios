//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRMetric;


@interface MKRMetricsCacheManager : MKRBaseCacheManager
- (void)saveMetricsList:(NSArray *)statsList;

- (MKRMetric *)metricWithId:(NSNumber *)metricId;

- (NSArray *)loadMetrics;

- (void)clearAllCache;
@end