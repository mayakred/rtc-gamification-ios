//
//  MKRAchivCollectionViewCell.m
//  rostel
//
//  Created by Mikhail Zinov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRAchivCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MKRUserAchievement.h"
#import "MKRUtils.h"


@implementation MKRAchivCollectionViewCell

- (void)setAchivvement:(MKRUserAchievement *)achiv {

    [self.achivImage sd_setImageWithURL:[NSURL URLWithString:achiv.achievement.image.standard] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (![achiv isDone]) {
            [self.grayAchivImage setHidden:NO];
            float maxVal = MAX(1.0f, [achiv.achievement.maxValue floatValue]);
            [self.achivImage setImage:image];
            
            [self.grayAchivImage setImage:[MKRUtils grayscaleImage:image]];
            
            [self.maskHeight setConstant:150 - 150 * [achiv.currentValue floatValue] / maxVal];
            [self layoutIfNeeded];
             
            
        } else {
            [self.grayAchivImage setHidden:YES];
        }
    }];
    
    //150
}

@end
