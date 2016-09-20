//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthService.h"
#import "MKRAuthCredentialCacheManager.h"
#import "MKRAuthSecretKey.h"
#import "MKRNetworkConfigManager.h"
#import "MKRErrorContainer.h"
#import "MKRAuthRequestNetworkMethod.h"
#import "MKRAuthConfirmNetworkMethod.h"
#import "MKRAuthCredentials.h"
#import "MKRLogoutNetworkMethod.h"


@implementation MKRAuthService {
    MKRAuthCredentialCacheManager *authCredentialManager;
    MKRAuthSecretKey *lastAuthSecretKey;
    MKRAuthRequestNetworkMethod *authRequestNetworkMethod;
    MKRAuthConfirmNetworkMethod *authConfirmNetworkMethod;
    MKRLogoutNetworkMethod *logoutNetworkMethod;
}


- (instancetype)initWithCredentialManager:(MKRAuthCredentialCacheManager *)credentialCacheManager {
    self = [super init];
    if (!self) {
        return nil;
    }

    authCredentialManager = credentialCacheManager;
    authRequestNetworkMethod = [[MKRAuthRequestNetworkMethod alloc] init];
    authConfirmNetworkMethod = [[MKRAuthConfirmNetworkMethod alloc] init];
    logoutNetworkMethod = [[MKRLogoutNetworkMethod alloc] init];
    lastAuthSecretKey = nil;

    return self;
}

- (BOOL)isAuthed {
    return [authCredentialManager isAuthed];
}

- (BOOL)isFirstAuth {
    return [authCredentialManager isFirstAuth];
}


- (NSString *)authToken {
    return [authCredentialManager authToken];
}

- (void)setTokenIsInvalid {
    [authCredentialManager setTokenIsInvalid];
    [MKRNetworkConfigManager clearAuthHeaderToken];
}

- (void)sendCodeToPhone:(NSString *)phone success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSParameterAssert(phone);

    NSLog(@"Start sending sms code to phone: %@", phone);
    lastAuthSecretKey = nil;
    [authRequestNetworkMethod sendCodeToPhone:phone success:^(MKRAuthSecretKey *authSecretKey) {
        NSLog(@"Success sending sms code to phone: %@", phone);
        NSLog(@"Received secret key: %@", authSecretKey.secret);
        lastAuthSecretKey = authSecretKey;
        successBlock();
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error sending code to phone: %@ Description:\n%@", phone, error.description);
        failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
    }];
}


- (void)authWithPhone:(NSString *)phone andCode:(NSString *)code success:(void (^)(BOOL isFirstAuth))successBlock
              failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSParameterAssert(phone);
    NSParameterAssert(code);
    //ensure that we have already got secret key from method above
    NSParameterAssert(lastAuthSecretKey);

    NSLog(@"Start auth with phone: %@ code: %@ secret: %@", phone, code, lastAuthSecretKey.secret);
    [authConfirmNetworkMethod authWithPhone:phone andCode:code andSecret:lastAuthSecretKey.secret
                              success:^(MKRAuthCredentials *newAuthCredentials) {
                                  NSLog(@"Success auth with phone: %@ code: %@ secret: %@", phone, code, lastAuthSecretKey.secret);
                                  NSLog(@"Received token: %@", newAuthCredentials.token);
                                  [authCredentialManager saveNewAuthCredentials:newAuthCredentials];
                                  [MKRNetworkConfigManager setAuthHeaderWithToken:[authCredentialManager authToken]];
                                  successBlock([authCredentialManager isFirstAuth]);

    } failure:^(NSError *error, NSArray *serverErrors) {
                NSLog(@"Error auth with phone: %@ code :%@ secret: %@ Description:\n%@", phone, code, lastAuthSecretKey.secret, error.description);
                failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
    }];
}

- (void)logoutWithSuccess:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSLog(@"Start logout");
    [logoutNetworkMethod logoutWithSuccess:^{
        NSLog(@"Success logout");
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error logout Description:\n%@", error.description);
        failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
    }];
}

- (void)sendAnotherCode {
//    [authNetworkManager sendAnotherCode];
}


@end