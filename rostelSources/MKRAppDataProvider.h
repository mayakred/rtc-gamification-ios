//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRAuthService.h"
#import "MKRPushService.h"
#import "MKRUserService.h"
#import "MKRStatsService.h"
#import "MKRMetricsService.h"
#import "MKRDuelsService.h"
#import "MKRGlobalErrorsObserver.h"

@interface MKRAppDataProvider : NSObject

@property (nonatomic, strong, readonly) MKRAuthService *authService;
@property (nonatomic, strong, readonly) MKRUserService *userService;
@property (nonatomic, strong, readonly) MKRPushService *pushService;
@property (nonatomic, strong, readonly) MKRDuelsService *duelsService;
@property (nonatomic, strong, readonly) MKRStatsService *statsService;
@property (nonatomic, strong, readonly) MKRMetricsService *metricsService;
@property (nonatomic, strong, readonly) MKRGlobalErrorsObserver *globalErrorsObserver;

+ (MKRAppDataProvider *)shared;

//need to call this in MKRAppDelegate first
- (void)extraInit;

// clue for improper use (produces compile time error)
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call shared instead")));
- (instancetype)init __attribute__((unavailable("init not available, call shared instead")));
+ (instancetype)new __attribute__((unavailable("new not available, call shared instead")));


@end
