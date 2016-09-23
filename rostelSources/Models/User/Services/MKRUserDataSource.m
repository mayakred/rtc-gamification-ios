//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserDataSource.h"
#import "MKRUserCacheManager.h"
#import "MKRUser.h"
#import "MKRFullUser.h"


@implementation MKRUserDataSource {
    MKRUserCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRUserCacheManager *)newCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    cacheManager = newCacheManager;

    return self;
}

- (MKRUser *)userWithId:(NSNumber *)itemId {
    return [cacheManager userWithId:itemId];
}

- (MKRFullUser *)fullUserWithId:(NSNumber *)itemId {
    return [cacheManager fullUserWithId:itemId];
}

- (NSArray *)usersIdsWithComparator:(NSComparator)comparator {
    NSArray *users = [cacheManager loadUsersList];
    NSMutableArray *result = [NSMutableArray new];
    NSArray *usersCopy = comparator ? [users sortedArrayUsingComparator:comparator] : users;
    for (MKRUser *user in usersCopy) {
        [result addObject:user.itemId];
    }
    return [NSArray arrayWithArray:result];
}
@end