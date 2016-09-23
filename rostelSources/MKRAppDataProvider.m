//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAppDataProvider.h"
#import "MKRNetworkConfigManager.h"
#import "MKRAuthCredentialCacheManager.h"

@interface MKRAppDataProvider()

@property (nonatomic, readwrite) MKRAuthService *authService;
@property (nonatomic, readwrite) MKRPushService *pushService;
@property (nonatomic, readwrite) MKRGlobalErrorsObserver *globalErrorsObserver;

@end

@implementation MKRAppDataProvider {
    MKRAuthCredentialCacheManager *credentialCacheManager;
}

+ (MKRAppDataProvider *)shared {
    static dispatch_once_t pred;
    static MKRAppDataProvider *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

- (instancetype)initUniqueInstance {
    self = [super init];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)extraInit {
    [MKRNetworkConfigManager setUpConfigs];

    NSLog(@"Init services");
    credentialCacheManager = [[MKRAuthCredentialCacheManager alloc] init];

    [self setAuthService:[[MKRAuthService alloc] initWithCredentialManager:credentialCacheManager]];
    [self setPushService:[[MKRPushService alloc] init]];
    [self setGlobalErrorsObserver:[[MKRGlobalErrorsObserver alloc] init]];

}

@end