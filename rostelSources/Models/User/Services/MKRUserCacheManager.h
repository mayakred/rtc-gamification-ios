//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRBaseCacheManager.h"
#import "MKRFullUser.h"


@interface MKRUserCacheManager : MKRBaseCacheManager
- (void)saveUser:(MKRUser *)newUser;

- (void)saveUsersList:(NSArray *)usersList;

- (MKRUser *)userWithId:(NSNumber *)userId;
- (MKRFullUser *)fullUserWithId:(NSNumber *)userId;

- (NSArray *)loadUsersList;

- (void)clearAllCache;
@end