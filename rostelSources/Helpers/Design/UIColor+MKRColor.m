//
//  UIColor+MKRColor.m
//  echeep
//
//  Created by Mikhail Zinov on 15.02.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import "UIColor+MKRColor.h"

@implementation UIColor (MKRColor)


+ (UIColor *)mkr_blueColor {
    return [UIColor colorWithRed:55.f/255.f green:122.f/255.f blue:187.f/255.f alpha:1];
}

+ (UIColor *)mkr_lightBlueColor {
    return [UIColor colorWithRed:216.f/255.f green:234.f/255.f blue:248.f/255.f alpha:1];
}

+ (UIColor *)mkr_darkBlueColor {
    return [UIColor colorWithRed:33.f/255.f green:76.f/255.f blue:154.f/255.f alpha:1];
}

+ (UIColor *)mkr_greyColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)mkr_lightGreyColor {
    return [UIColor colorWithWhite:170.0f/255.0f alpha:1];
}

+ (UIColor *)mkr_darkGreyColor {
    return [UIColor colorWithWhite:123.0f/255.0f alpha:1];
}

+ (UIColor *)mkr_greenColor {
    return [UIColor colorWithRed:0 green:105.f/255.f blue:0 alpha:1];
}

+ (UIColor *)mkr_redColor {
    return [UIColor redColor];
}

@end
