//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserMetricCacheManager.h"
#import "MKRSecurityManager.h"
#import "MKRUserMetricValue.h"


@implementation MKRUserMetricCacheManager {

}



- (void)saveMetricsList:(NSArray *)statsList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:statsList];
    [realm commitWriteTransaction];
}

- (MKRUserMetricValue *)userMetricWithId:(NSNumber *)metricId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRUserMetricValue objectInRealm:realm forPrimaryKey:metricId];
}

- (NSArray *)loadUsersMetrics {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [self RLMResultsToNSArray:[MKRUserMetricValue allObjectsInRealm:realm]];
}

- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRUserMetricValue allObjectsInRealm:realm]];
    [realm commitWriteTransaction];
}


@end