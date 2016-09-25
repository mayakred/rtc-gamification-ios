//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRMetric;
@class MKRMetricsListPresenter;


@interface MKRMetricsService : NSObject
- (void)loadMetricsListFromServerWithPresenter:(MKRMetricsListPresenter *)presenter;

- (MKRMetric *)metricWithId:(NSNumber *)itemId;

- (NSArray *)metricsIdsWithComparator:(NSComparator)comparator;

- (void)clearAllCache;
@end