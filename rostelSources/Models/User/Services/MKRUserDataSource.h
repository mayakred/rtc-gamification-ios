//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRUserCacheManager;
@class MKRUser;
@class MKRFullUser;


@interface MKRUserDataSource : NSObject
- (instancetype)initWithCacheManager:(MKRUserCacheManager *)newCacheManager;

- (MKRUser *)userWithId:(NSNumber *)itemId;

- (MKRFullUser *)fullUserWithId:(NSNumber *)itemId;

- (NSArray *)usersIdsWithComparator:(NSComparator)comparator;
@end