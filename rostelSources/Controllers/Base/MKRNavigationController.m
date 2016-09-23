//
//  MKRNavigationController.m
//  echeep
//
//  Created by Anton Zlotnikov on 10.02.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import "MKRNavigationController.h"
#import "UIColor+MKRColor.h"

@interface MKRNavigationController ()

@end

@implementation MKRNavigationController {
    MKRNavBarStyle style;
    CALayer *topBorder;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationBar setBarStyle:UIBarStyleDefault];
    //TODO find another solution
    UIBarButtonItem *navBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [navBarButtonAppearance setTitleTextAttributes:@{
            NSFontAttributeName:            [UIFont systemFontOfSize:0.1],
            NSForegroundColorAttributeName: [UIColor clearColor]
    } forState:UIControlStateNormal];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, self.navigationBar.frame.size.height, self.view.frame.size.width, 0.5f);
    topBorder.backgroundColor = [[UIColor mkr_blueColor] CGColor];
    [self.navigationBar.layer addSublayer:topBorder];
    [self setBlueStyle];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (MKRNavBarStyle)navBarStyle {
    return style;
}

- (void)setBlueStyle {
    style = MKRNavBarStyleBlue;
    [topBorder setHidden:NO];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor whiteColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17]
    }];
    [self.navigationBar setBarTintColor:[UIColor mkr_blueColor]];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setWhiteStyle {
    style = MKRNavBarStyleWhite;
    [topBorder setHidden:NO];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName:[UIColor blackColor],
            NSFontAttributeName:[UIFont systemFontOfSize:17]
    }];
    [self.navigationBar setTintColor:[UIColor mkr_blueColor]];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setTransparentStyle {
    style = MKRNavBarStyleTransparent;
    [topBorder setHidden:YES];
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName : [UIColor whiteColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17]
    }];
    [self.navigationBar setBarTintColor:[UIColor clearColor]];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (style) {
        case MKRNavBarStyleBlue:return UIStatusBarStyleLightContent;
        case MKRNavBarStyleWhite:return UIStatusBarStyleDefault;
        case MKRNavBarStyleTransparent:return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
