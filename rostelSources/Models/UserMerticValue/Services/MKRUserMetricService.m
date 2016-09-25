//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserMetricService.h"
#import "MKRMetricsValueListNetworkMethod.h"
#import "CocoaSecurity.h"
#import "MKRUserMetricCacheManager.h"
#import "MKRUserMetricDataSource.h"
#import "MKRUsersMetricsPresenter.h"
#import "MKRUserMetricValue.h"
#import "MKRUsersMetricsPresenter.h"
#import "MKRErrorContainer.h"


@implementation MKRUserMetricService {
    MKRMetricsValueListNetworkMethod *metricsValueListNetworkMethod;
    MKRUserMetricCacheManager *cacheManager;
    MKRUserMetricDataSource *dataSource;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = [[MKRUserMetricCacheManager alloc] init];
    metricsValueListNetworkMethod = [[MKRMetricsValueListNetworkMethod alloc] init];
    dataSource = [[MKRUserMetricDataSource alloc] initWithCacheManager:cacheManager];

    return self;
}

- (void)loadMetricsListFromServerWithPresenter:(MKRUsersMetricsPresenter *)presenter {
    NSLog(@"Start loading users list");
    [presenter serviceWillUpdateMetricsList];
    [metricsValueListNetworkMethod userMetricsListWithMetricCode:[presenter getMetricCode] andPerviySubview:[presenter getIsPerviySubview] success:^(NSArray *metricsList) {
        NSLog(@"Success loading users list");
//        [cacheManager clearUsersListCache];
        [cacheManager saveMetricsList:metricsList];
        [presenter serviceUpdatedMetricsListSuccessfully];
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error loading users list Description:\n%@", error.description);
        [presenter serviceUpdatedMetricsListWithError:[MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]];
    }];
}

- (NSArray *)usersMetricsIdsWithPerviySubview:(BOOL)perviySubiew andMetricCode:(NSString *)mCode andComparator:(NSComparator)comparator {
    return [dataSource usersMetricsIdsWithPerviySubview:perviySubiew andMetricCode:mCode andComparator:comparator];
}

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)itemId {
    return [dataSource userMetricWithId:itemId];
}

- (void)clearAllCache {
    [cacheManager clearAllCache];
}

@end