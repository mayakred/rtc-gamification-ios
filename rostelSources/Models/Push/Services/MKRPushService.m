//
// Created by Anton Zlotnikov on 31.05.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRPushService.h"
#import "MKRRegisterPushNotificationsNetworkMethod.h"
#import "MKRErrorContainer.h"
#import "MKRAppDelegate.h"
#import "MKRAppDataProvider.h"


@implementation MKRPushService {
    MKRRegisterPushNotificationsNetworkMethod *registerPushNotificationsNetworkMethod;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    registerPushNotificationsNetworkMethod = [[MKRRegisterPushNotificationsNetworkMethod alloc] init];

    return self;
}

- (void)registerWithPlayerId:(NSString *)playerId success:(void (^)())successBlock failure:(void (^)(MKRErrorContainer *errorContainer))failureBlock {
    NSParameterAssert(playerId);
    NSLog(@"Start register with player id: %@", playerId);
    [registerPushNotificationsNetworkMethod registerWithPlayerId:playerId success:^{
        NSLog(@"Success register with player id: %@", playerId);
        successBlock();
    } failure:^(NSError *error, NSArray *serverErrors) {
        NSLog(@"Error register with player id: %@ Description:\n%@", playerId, error.description);
        failureBlock([MKRErrorContainer errorContainerWithError:error andServerErrors:serverErrors]);
    }];
}

- (void)unregisterForPushNotifications {
    MKRAppDelegate *delegate = (MKRAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.oneSignal setSubscription:NO];
}

- (void)registerForPushNotifications {
    MKRAppDelegate *delegate = (MKRAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.oneSignal registerForPushNotifications];
    [delegate.oneSignal IdsAvailable:^(NSString *userId, NSString *pushToken) {
        [delegate.oneSignal setSubscription:YES];
        [[MKRAppDataProvider shared].pushService registerWithPlayerId:userId success:^{

        } failure:^(MKRErrorContainer *errorContainer) {

        }];
    }];
}


@end