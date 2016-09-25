//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRMetric;

@protocol MKRMetricsListDataDelegate <NSObject>
@required
- (void)metricsListDidUpdateSuccess;
- (void)metricsListDidUpdateWithError:(MKRErrorContainer *)errorContainer;
- (void)metricsListWillUpdate;
@end


@interface MKRMetricsListPresenter : NSObject

@property (nonatomic, weak) id <MKRMetricsListDataDelegate> delegate;

- (void)loadMetricsIds;

- (void)updateMetrics;

- (MKRMetric *)metricWithIndex:(NSUInteger)index;

- (NSUInteger)metricsCount;

- (void)serviceUpdatedMetricsListSuccessfully;

- (void)serviceUpdatedMetricsListWithError:(MKRErrorContainer *)errorContainer;

- (void)serviceWillUpdateMetricsList;

@end