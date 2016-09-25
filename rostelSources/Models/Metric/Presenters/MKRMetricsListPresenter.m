//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsListPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRMetric.h"
#import "MKRAppDataProvider.h"


@implementation MKRMetricsListPresenter {
    NSArray *metricsIds;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return self;
    }
    [self loadMetricsIds];

    return self;
}

- (NSComparator)getComparatorSort {
    return nil;
//    return ^NSComparisonResult(MKRUser *a, MKRUser* b) {
//        return [a.topPosition compare:b.topPosition];
//    };
}


- (void)loadMetricsIds {
    metricsIds = [[MKRAppDataProvider shared].metricsService metricsIdsWithComparator:[self getComparatorSort]];
}

- (void)updateMetrics {
    [[MKRAppDataProvider shared].metricsService loadMetricsListFromServerWithPresenter:self];
}

- (MKRMetric *)metricWithIndex:(NSUInteger)index {
    return [[MKRAppDataProvider shared].metricsService metricWithId:metricsIds[index]];
}

- (NSUInteger)metricsCount {
    return [metricsIds count];
}

- (void)serviceUpdatedMetricsListSuccessfully {
    [self loadMetricsIds];
    if (self.delegate) {
        [self.delegate metricsListDidUpdateSuccess];
    }
}

- (void)serviceUpdatedMetricsListWithError:(MKRErrorContainer *)errorContainer {
    if (self.delegate) {
        [self.delegate metricsListDidUpdateWithError:errorContainer];
    }
}

- (void)serviceWillUpdateMetricsList {
    if (self.delegate) {
        [self.delegate metricsListWillUpdate];
    }
}

@end