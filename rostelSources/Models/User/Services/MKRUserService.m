//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRUserService.h"
#import "MKRGetCurrentUserNetworkMethod.h"
#import "MKRErrorContainer.h"
#import "MKRAuthCredentialCacheManager.h"
#import "MKRUserCacheManager.h"
#import "MKRFullUser.h"
#import "MKRGetUserNetworkMethod.h"
#import "MKRUsersListNetworkMethod.h"
#import "MKRUsersListPresenter.h"


@implementation MKRUserService {
    MKRGetCurrentUserNetworkMethod *getCurrentUserNetworkMethod;
    MKRGetUserNetworkMethod *getUserNetworkMethod;
    MKRUsersListNetworkMethod *usersListNetworkMethod;
    MKRAuthCredentialCacheManager *authCredentialCacheManager;
    MKRUserCacheManager *cacheManager;
}

- (instancetype)initWithCacheManager:(MKRAuthCredentialCacheManager *)credentialCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    authCredentialCacheManager = credentialCacheManager;

    getCurrentUserNetworkMethod = [[MKRGetCurrentUserNetworkMethod alloc] init];
    getUserNetworkMethod = [[MKRGetUserNetworkMethod alloc] init];
    usersListNetworkMethod = [[MKRUsersListNetworkMethod alloc] init];
    cacheManager = [[MKRUserCacheManager alloc] init];

    return self;
}

- (void)getCurrentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSLog(@"Start loading current user");
    [getCurrentUserNetworkMethod currentUserWithSuccess:^(MKRFullUser *user) {
        [cacheManager saveUser:user];
        if (successBlock) {
            successBlock(user);
        }
    } failure:^(NSError *error, NSArray *serverErrors) {
        if (failureBlock) {
            failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
        }
    }];
}

- (void)getUserWithId:(NSNumber *)userId success:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSParameterAssert(userId);
    NSLog(@"Start loading user with id %@", userId);
    [getUserNetworkMethod currentUserWithId:userId success:^(MKRFullUser *user) {
        [cacheManager saveUser:user];
        if (successBlock) {
            successBlock(user);
        }
    } failure:^(NSError *error, NSArray *serverErrors) {
        if (failureBlock) {
            failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
        }
    }];
}

- (void)loadUsersListFromServerWithPresenter:(MKRUsersListPresenter *)presenter {
    NSLog(@"Start loading users list");
    [presenter serviceWillUpdateUsersList];
    [usersListNetworkMethod usersListWithSuccess:^(NSArray *usersList) {
        NSLog(@"Success loading users list");
        [cacheManager saveUsersList:usersList];
        [presenter serviceUpdatedUsersListSuccessfully];
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error loading users list Description:\n%@", error.description);
        [presenter serviceUpdatedUsersListWithError:[MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]];
    }];
}




- (MKRFullUser *)currentUser {
    return [cacheManager fullUserWithId:[authCredentialCacheManager userId]];
}



@end