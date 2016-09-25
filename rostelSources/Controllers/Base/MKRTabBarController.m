//
//  MKRTabBarController.m
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRTabBarController.h"
#import "UIColor+MKRColor.h"
#import "MKRAppDataProvider.h"
#import "MKRNavigationController.h"
#import "MKRProfileViewController.h"
#import "MKRFullUser.h"

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
    UIStoryboard *profileStoryboard = [UIStoryboard storyboardWithName:@"profile" bundle:nil];
    MKRNavigationController *profileNavController = [profileStoryboard instantiateInitialViewController];
    [(MKRProfileViewController *)profileNavController.visibleViewController setUserId:[MKRAppDataProvider shared].userService.currentUser.itemId];
    [profileNavController.tabBarItem setImage:[UIImage imageNamed:@"profile-ico"]];
    [profileNavController.tabBarItem setTitle:@"Профиль"];
    
    UIStoryboard *ratingStoryboard = [UIStoryboard storyboardWithName:@"rating" bundle:nil];
    MKRNavigationController *ratingNavController = [ratingStoryboard instantiateInitialViewController];
    [ratingNavController.tabBarItem setImage:[UIImage imageNamed:@"raiting-bar-icon"]];
    [ratingNavController.tabBarItem setTitle:@"Рейтинг"];

    UIStoryboard *duelStoryboard = [UIStoryboard storyboardWithName:@"duel" bundle:nil];
    MKRNavigationController *duelNavController = [duelStoryboard instantiateInitialViewController];
    [duelNavController.tabBarItem setImage:[UIImage imageNamed:@"fight-icon"]];
    [duelNavController.tabBarItem setTitle:@"Дуэли"];
    
    UIStoryboard *achievementStoryboard = [UIStoryboard storyboardWithName:@"achiv" bundle:nil];
    MKRNavigationController *achievementNavController = [achievementStoryboard instantiateInitialViewController];
    [achievementNavController.tabBarItem setImage:[UIImage imageNamed:@"achiv-icon"]];
    [achievementNavController.tabBarItem setTitle:@"Достижения"];
    
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"settings" bundle:nil];
    MKRNavigationController *settingsNavController = [settingsStoryboard instantiateInitialViewController];
    [settingsNavController.tabBarItem setImage:[UIImage imageNamed:@"settings-icon"]];
    [settingsNavController.tabBarItem setTitle:@"Настройки"];

    [self setViewControllers:@[
            profileNavController,
            ratingNavController,
            duelNavController,
            achievementNavController,
            settingsNavController
    ]];
    
    [[MKRAppDataProvider shared].pushService registerForPushNotifications];
}

@end
