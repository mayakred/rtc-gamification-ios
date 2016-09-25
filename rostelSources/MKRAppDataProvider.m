//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAppDataProvider.h"
#import "MKRNetworkConfigManager.h"
#import "MKRAuthCredentialCacheManager.h"
#import "MKRUserMetricService.h"

@interface MKRAppDataProvider()

@property (nonatomic, readwrite) MKRAuthService *authService;
@property (nonatomic, readwrite) MKRPushService *pushService;
@property (nonatomic, readwrite) MKRUserService *userService;
@property (nonatomic, readwrite) MKRStatsService *statsService;
@property (nonatomic, readwrite) MKRDuelsService *duelsService;
@property (nonatomic, readwrite) MKRUserMetricService *userMetricService;
@property (nonatomic, readwrite) MKRMetricsService *metricsService;
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
    [self setUserService:[[MKRUserService alloc] initWithCacheManager:credentialCacheManager]];
    [self setPushService:[[MKRPushService alloc] init]];
    [self setDuelsService:[[MKRDuelsService alloc] init]];
    [self setStatsService:[[MKRStatsService alloc] init]];
    [self setMetricsService:[[MKRMetricsService alloc] init]];
    [self setUserMetricService:[[MKRUserMetricService alloc] init]];
    [self setGlobalErrorsObserver:[[MKRGlobalErrorsObserver alloc] init]];

}

@end
