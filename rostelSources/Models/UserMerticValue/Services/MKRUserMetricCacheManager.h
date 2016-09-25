//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"

@class MKRUserMetricValue;


@interface MKRUserMetricCacheManager : MKRBaseCacheManager
- (void)saveMetricsList:(NSArray *)statsList;

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)metricId;

- (NSArray *)loadUsersMetrics;

- (void)clearAllCache;
@end