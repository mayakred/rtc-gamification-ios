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

@implementation MKRAuthSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MKRTabBarController *tabBarController = [[MKRTabBarController alloc] init];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:tabBarController animated:YES];
}

@end
