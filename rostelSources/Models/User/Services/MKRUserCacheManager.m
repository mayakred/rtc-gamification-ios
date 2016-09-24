//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Realm/Realm.h>
#import "MKRUserCacheManager.h"
#import "MKRUser.h"
#import "MKRSecurityManager.h"


@implementation MKRUserCacheManager {

}

- (void)saveUser:(MKRUser *)newUser {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:newUser];
    [realm commitWriteTransaction];
}

- (void)saveUsersList:(NSArray *)usersList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:usersList];
    [realm commitWriteTransaction];
}

- (MKRUser *)userWithId:(NSNumber *)userId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRUser objectInRealm:realm forPrimaryKey:userId];
}

- (MKRFullUser *)fullUserWithId:(NSNumber *)userId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRFullUser objectInRealm:realm forPrimaryKey:userId];
}

- (NSArray *)loadUsersList {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [self RLMResultsToNSArray:[MKRUser allObjectsInRealm:realm]];
}

- (void)clearUsersListCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[self loadUsersList]];
    [realm commitWriteTransaction];
}

- (void)clearAllCache {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[self loadUsersList]];
    [realm deleteObjects:[MKRFullUser allObjectsInRealm:realm]];
    [realm commitWriteTransaction];
}

@end