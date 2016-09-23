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

- (MKRUser *)userWithId:(NSNumber *)userId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRUser objectInRealm:realm forPrimaryKey:userId];
}

- (MKRFullUser *)fullUserWithId:(NSNumber *)userId {
    RLMRealm *realm = [MKRSecurityManager getRealm];
    return [MKRFullUser objectInRealm:realm forPrimaryKey:userId];
}


@end