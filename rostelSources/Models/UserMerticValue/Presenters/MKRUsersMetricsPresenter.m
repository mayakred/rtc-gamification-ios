//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUsersMetricsPresenter.h"
#import "MKRErrorContainer.h"
#import "MKRUserMetricValue.h"
#import "MKRAppDataProvider.h"


@implementation MKRUsersMetricsPresenter {
    NSArray *metricsIds;
    NSString *metricCode;
    BOOL perviySubview;

}
- (instancetype)initWitIsPerviySubview:(BOOL)pS andMetricCode:(NSString *)mCode {
    self = [super init];
    if (!self) {
        return nil;
    }
    metricCode = mCode;
    perviySubview = pS;

    return self;
}

- (NSComparator)getComparatorSort {
    return ^NSComparisonResult(MKRUserMetricValue *a, MKRUserMetricValue* b) {
        return [a.metricValue compare:b.metricValue];
    };
}

- (BOOL)getIsPerviySubview {
    return perviySubview;
}

- (NSString *)getMetricCode {
    return metricCode;
}

- (void)loadUsersMetricsIds {
    metricsIds = [[MKRAppDataProvider shared].metricsService metricsIdsWithComparator:[self getComparatorSort]];
}

- (void)updateUsersMetrics {
    [[MKRAppDataProvider shared].userMetricService loadMetricsListFromServerWithPresenter:self];
}

- (MKRUserMetricValue *)userMetricWithIndex:(NSUInteger)index {
    return [[MKRAppDataProvider shared].userMetricService userMetricWithId:metricsIds[index]];
}

- (NSUInteger)usersMetricsCount {
    return [metricsIds count];
}

- (void)serviceUpdatedMetricsListSuccessfully {
    [self loadUsersMetricsIds];
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