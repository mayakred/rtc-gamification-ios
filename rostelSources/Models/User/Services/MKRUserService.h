//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRAuthCredentialCacheManager;
@class MKRFullUser;
@class MKRUsersListPresenter;
@class MKRUser;


@interface MKRUserService : NSObject
- (instancetype)initWithCacheManager:(MKRAuthCredentialCacheManager *)credentialCacheManager;

- (void)getCurrentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)getUserWithId:(NSNumber *)userId success:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)loadUsersListFromServerWithPresenter:(MKRUsersListPresenter *)presenter;

- (MKRFullUser *)currentUser;

- (NSArray *)usersIdsWithDepartmentCode:(NSString *)departmentCode andComparator:(NSComparator)comparator;

- (MKRFullUser *)fullUserWithId:(NSNumber *)userId;

- (MKRUser *)userWithId:(NSNumber *)userId;
@end