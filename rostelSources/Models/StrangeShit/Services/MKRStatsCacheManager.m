//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStatsCacheManager.h"
#import "MKRSecurityManager.h"
#import "MKRStrangeObject.h"


@implementation MKRStatsCacheManager {

}

- (void)saveStatsList:(NSArray *)statsList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:statsList];
    [realm commitWriteTransaction];
}

- (MKRStrangeObject *)statWithId:(NSNumber *)statId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRStrangeObject objectInRealm:realm forPrimaryKey:statId];
}

- (NSArray *)loadStats {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [self RLMResultsToNSArray:[MKRStrangeObject allObjectsInRealm:realm]];
}

- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[MKRStrangeObject allObjectsInRealm:realm]];
    [realm commitWriteTransaction];
}


@end
