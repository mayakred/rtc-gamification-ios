//
//   
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRAuthSplashViewController.h"
#import "MKRTabBarController.h"
#import "UIWindows+Additions.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"

@implementation MKRAuthSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCurrentUser];
}

- (void)goToTabBarController {
    MKRTabBarController *tabBarController = [[MKRTabBarController alloc] init];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:tabBarController animated:YES];
}

- (void)loadCurrentUser {
    [[MKRAppDataProvider shared].userService getCurrentUserWithSuccess:^(MKRFullUser *user) {
        NSLog(@"%@", user);
        [self goToTabBarController];
    } failure:^(MKRErrorContainer *errorContainer) {
        UIAlertController *loadErrorView = [UIAlertController alertControllerWithTitle:@"Не удалось загрузить данные"
                                                                               message:nil
                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* retryAction = [UIAlertAction
                actionWithTitle:@"Повторить" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    [self performSelector:@selector(loadCurrentUser) withObject:nil afterDelay:0.5];
                }];
        [loadErrorView addAction:retryAction];
        [self presentViewController:loadErrorView animated:YES completion:nil];
    }];
}


@end
