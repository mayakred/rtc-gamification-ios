//
// Created by Anton Zlotnikov on 21.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRErrorContainer;
@class MKRAuthCredentialCacheManager;
@class MKRFullUser;


@interface MKRUserService : NSObject
- (instancetype)initWithCacheManager:(MKRAuthCredentialCacheManager *)credentialCacheManager;

- (void)getCurrentUserWithSuccess:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)getUserWithId:(NSNumber *)userId success:(void (^)(MKRFullUser *user))successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (MKRFullUser *)currentUser;

@end