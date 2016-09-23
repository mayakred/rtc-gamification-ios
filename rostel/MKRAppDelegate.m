//
//  MKRAppDelegate.m
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRAppDelegate.h"
#import "MKRAppDataProvider.h"
#import "MKRNetworkConfigManager.h"
#import "UIWindows+Additions.h"
#import "MKRTabBarController.h"
#import "MKRConsts.h"

@interface MKRAppDelegate ()

@end

@implementation MKRAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Application launched");
    [[MKRAppDataProvider shared] extraInit];
    // OneSignal
    self.oneSignal = [[OneSignal alloc] initWithLaunchOptions:launchOptions appId:ONE_SIGNAL_APP_ID
                                           handleNotification:^(NSString *message, NSDictionary *additionalData, BOOL isActive) {
                                               if (additionalData) {
//                                                   [self handlePushWithUserInfo:additionalData isActive:isActive];
                                               }
                                           } autoRegister:NO];
    
    [self.oneSignal enableInAppAlertNotification:YES];

    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
//    [[[MKRAppDataProvider shared] authService] setTokenIsInvalid];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"auth" bundle:nil];
    if ([[[MKRAppDataProvider shared] authService] isAuthed]) {
        [MKRNetworkConfigManager setAuthHeaderWithToken:[[[MKRAppDataProvider shared] authService] authToken]];
        [self.window setRootViewController:[[MKRTabBarController alloc] init] animated:YES];
    } else {
        [self.window setRootViewController:[storyboard instantiateInitialViewController] animated:YES];
    }

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
