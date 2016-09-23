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
    return [UIColor colorWithRed:0/255.f green:170.f/255.f blue:231.f/255.f alpha:1];
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

+ (UIColor *)mkr_emptyDataSetColor {
//    return [UIColor colorWithRed:244.f/255.f green:244.f/255.f blue:244.f/255.f alpha:1];
    return [UIColor whiteColor];
}

@end
