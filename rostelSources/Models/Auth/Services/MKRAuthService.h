//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKRAuthSecretKey;
@class MKRErrorContainer;
@class MKRAuthCredentialCacheManager;

@interface MKRAuthService : NSObject

- (instancetype)initWithCredentialManager:(MKRAuthCredentialCacheManager *)credentialCacheManager;

- (BOOL)isAuthed;
- (BOOL)isFirstAuth;
- (NSString *)authToken;

- (void)setTokenIsInvalid;

- (void)sendCodeToPhone:(NSString *)phone success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)authWithPhone:(NSString *)phone andCode:(NSString *)code success:(void (^)(BOOL isFirstAuth))successBlock
              failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)logoutWithSuccess:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock;

- (void)sendAnotherCode;

@end