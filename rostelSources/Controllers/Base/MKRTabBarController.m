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
    UIStoryboard *ratingStoryboard = [UIStoryboard storyboardWithName:@"rating" bundle:nil];
    MKRNavigationController *ratingNavController = [ratingStoryboard instantiateInitialViewController];
    [ratingNavController.tabBarItem setImage:nil];
    [ratingNavController.tabBarItem setTitle:@"Рейтинг"];

    UIStoryboard *profileStoryboard = [UIStoryboard storyboardWithName:@"profile" bundle:nil];
    MKRNavigationController *profileNavController = [profileStoryboard instantiateInitialViewController];
    [profileNavController.tabBarItem setImage:nil];
    [profileNavController.tabBarItem setTitle:@"Профиль"];

    [self setViewControllers:@[
            profileNavController,
            ratingNavController,
    ]];
    [[MKRAppDataProvider shared].pushService registerForPushNotifications];
}

@end
