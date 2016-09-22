//
//  MKRTabBarController.m
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRTabBarController.h"
#import "UIColor+MKRColor.h"

@interface MKRTabBarController ()

@end

@implementation MKRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor mkr_blueColor]];
    [self initControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initControllers {
//    MKRNavigationController *discountsNavigationController = [[UIStoryboard storyboardWithName:@"promotions" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MKRPromotionsViewController class])];
//    [discountsNavigationController setTitle:NSLocalizedString(LOC_DISCOUNTS_TITLE, @"TabBarItem Discounts")];
//    [discountsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"saleTabbarIcon"]];
//    [discountsNavigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"saleTabbarSelectedIcon"]];
//
//    MKRNavigationController *giftNavigationController = [[UIStoryboard storyboardWithName:@"gifts" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MKRGiftsViewController class])];
//    [giftNavigationController setTitle:NSLocalizedString(LOC_GIFTS_TITLE, @"TabBarItem Gifts")];
//    [giftNavigationController.tabBarItem setImage:[UIImage imageNamed:@"giftTabbarIcon"]];
//    [giftNavigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"giftTabbarSelectedIcon"]];
//
//    MKRNavigationController *subscriptionsNavigationController = [[UIStoryboard storyboardWithName:@"subscribtions" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MKRNotificationsViewController class])];
//    [subscriptionsNavigationController.tabBarItem setTitle:NSLocalizedString(LOC_SUBS_TITLE, @"TabBatItem Subscriptions")];
//    [subscriptionsNavigationController.tabBarItem setImage: [UIImage imageNamed:@"notificationTabbarIcon"]];
//    [subscriptionsNavigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"notificationTabbarSelectedIcon"]];
//
//    [[MKRAppDataProvider shared].tabBarItemBadgeService setNotificationTabBarItem:subscriptionsNavigationController.tabBarItem];
//    [[MKRAppDataProvider shared].tabBarItemBadgeService loadIncomeNotificationsCount];
//
//    MKRNavigationController *settingsNavigationController = [[UIStoryboard storyboardWithName:@"settings" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MKRSettingsViewController class])];
//    [settingsNavigationController setTitle:NSLocalizedString(LOC_SETTINGS_TITLE, @"TabBarItem Settings")];
//    [settingsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"settingsTabbarIcon"]];
//    [settingsNavigationController.tabBarItem setSelectedImage:[UIImage imageNamed:@"settingsTabbarSelectedIcon"]];
//
//    [self setViewControllers:@[
//            discountsNavigationController,
//            giftNavigationController,
//            subscriptionsNavigationController,
//            settingsNavigationController
//    ]];
//    [[MKRAppDataProvider shared].pushService registerForPushNotifications];
}

@end
