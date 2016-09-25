//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetricsCacheManager.h"
#import "MKRSecurityManager.h"
#import "MKRMetric.h"


@implementation MKRMetricsCacheManager {

}


- (void)saveMetricsList:(NSArray *)statsList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:statsList];
    [realm commitWriteTransaction];
}

- (MKRMetric *)metricWithId:(NSNumber *)metricId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRMetric objectInRealm:realm forPrimaryKey:metricId];
}

- (NSArray *)loadMetrics {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [self RLMResultsToNSArray:[MKRMetric allObjectsInRealm:realm]];
}

- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRMetric allObjectsInRealm:realm]];
    [realm commitWriteTransaction];
}

@end