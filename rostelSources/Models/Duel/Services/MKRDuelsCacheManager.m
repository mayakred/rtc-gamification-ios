//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuelsCacheManager.h"
#import "MKRSecurityManager.h"
#import "MKRDuel.h"


@implementation MKRDuelsCacheManager {

}

- (void)saveDuel:(MKRDuel *)duel {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:duel];
    [realm commitWriteTransaction];
}

- (void)saveDuelsList:(NSArray *)usersList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:usersList];
    [realm commitWriteTransaction];
}

- (MKRDuel *)duelWithId:(NSNumber *)duelId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRDuel objectInRealm:realm forPrimaryKey:duelId];
}

- (NSArray *)loadDuelsList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [self RLMResultsToNSArray:[MKRDuel allObjectsInRealm:realm]];
}

- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[self loadDuelsList]];
    [realm commitWriteTransaction];
}

@end