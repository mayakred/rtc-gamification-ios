//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRUserMetricCacheManager;
@class MKRUserMetricValue;


@interface MKRUserMetricDataSource : NSObject
- (instancetype)initWithCacheManager:(MKRUserMetricCacheManager *)newCacheManager;

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)itemId;

- (NSArray *)usersMetricsIdsWithPerviySubview:(BOOL)perviySubiew andComparator:(NSComparator)comparator;
@end