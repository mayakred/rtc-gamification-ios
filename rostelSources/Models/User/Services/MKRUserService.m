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


@implementation MKRUserService {
    MKRGetCurrentUserNetworkMethod *getCurrentUserNetworkMethod;
    MKRGetUserNetworkMethod *getUserNetworkMethod;
    MKRAuthCredentialCacheManager *authCredentialCacheManager;
    MKRUserCacheManager *userCacheManager;
}

- (instancetype)initWithCacheManager:(MKRAuthCredentialCacheManager *)credentialCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }
    authCredentialCacheManager = credentialCacheManager;

    getCurrentUserNetworkMethod = [[MKRGetCurrentUserNetworkMethod alloc] init];
    getUserNetworkMethod = [[MKRGetUserNetworkMethod alloc] init];
    userCacheManager = [[MKRUserCacheManager alloc] init];

    return self;
}

- (void)getCurrentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSLog(@"Start loading current user");
    [getCurrentUserNetworkMethod currentUserWithSuccess:^(MKRFullUser *user) {
        [userCacheManager saveUser:user];
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
        [userCacheManager saveUser:user];
        if (successBlock) {
            successBlock(user);
        }
    } failure:^(NSError *error, NSArray *serverErrors) {
        if (failureBlock) {
            failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
        }
    }];
}



- (MKRFullUser *)currentUser {
    return [userCacheManager fullUserWithId:[authCredentialCacheManager userId]];
}



@end