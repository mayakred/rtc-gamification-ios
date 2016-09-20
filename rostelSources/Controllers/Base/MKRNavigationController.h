//
//  MKRNavigationController.h
//  echeep
//
//  Created by Anton Zlotnikov on 10.02.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MKRNavBarStyle) {
    MKRNavBarStyleBlue = 0,
    MKRNavBarStyleWhite,
    MKRNavBarStyleTransparent,
};


@interface MKRNavigationController : UINavigationController

- (MKRNavBarStyle)navBarStyle;

- (void)setBlueStyle;

- (void)setWhiteStyle;

- (void)setTransparentStyle;
@end
