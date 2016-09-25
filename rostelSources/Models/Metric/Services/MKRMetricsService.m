//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsService.h"
#import "MKRMetricsListNetworkMethod.h"
#import "MKRMetricsCacheManager.h"
#import "MKRMetric.h"
#import "MKRMetricsDataSource.h"
#import "MKRMetricsListPresenter.h"
#import "MKRErrorContainer.h"


@implementation MKRMetricsService {
    MKRMetricsListNetworkMethod *metricsListNetworkMethod;
    MKRMetricsCacheManager *cacheManager;
    MKRMetricsDataSource *dataSource;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    metricsListNetworkMethod = [[MKRMetricsListNetworkMethod alloc] init];
    cacheManager = [[MKRMetricsCacheManager alloc] init];
    dataSource = [[MKRMetricsDataSource alloc] initWithCacheManager:cacheManager];

    return self;
}

- (void)loadMetricsListFromServerWithPresenter:(MKRMetricsListPresenter *)presenter {
    NSLog(@"Start loading users list");
    [presenter serviceWillUpdateMetricsList];
    [metricsListNetworkMethod metricsListWithSuccess:^(NSArray *metricsList) {
        NSLog(@"Success loading users list");
//        [cacheManager clearUsersListCache];
        [cacheManager saveMetricsList:metricsList];
        [presenter serviceUpdatedMetricsListSuccessfully];
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error loading users list Description:\n%@", error.description);
        [presenter serviceUpdatedMetricsListWithError:[MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]];
    }];
}

- (MKRMetric *)metricWithId:(NSNumber *)itemId {
    return [dataSource metricWithId:itemId];
}

- (NSArray *)metricsIdsWithComparator:(NSComparator)comparator {
    return [dataSource metricsIdsWithComparator:comparator];
}

- (void)clearAllCache {
    [cacheManager clearAllCache];
}


@end
