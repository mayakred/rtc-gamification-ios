//
//  MKRRatingTableViewCell.m
//  rostel
//
//  Created by Anton Zlotnikov on 23.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRRatingTableViewCell.h"
#import "MKRUser.h"
#import "MKRUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MKRRatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MKRUser *)user andPosition:(NSInteger)position {
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
    [self.departmentLabel setText:user.department.name];
    [self setUserId:user.itemId];
    
    if (position < 4) {
        [self.positionNumberlabel setHidden:YES];
        [self.placeImage setHidden:NO];
    } else {
        [self.positionNumberlabel setHidden:NO];
        [self.placeImage setHidden:YES];
        [self.positionNumberlabel setText:[NSString stringWithFormat:@"%d", position]];
    }
    
    if (position == 1) {
        [self.placeImage setImage:[UIImage imageNamed:@"gold-place"]];
    } else if (position == 2) {
        [self.placeImage setImage:[UIImage imageNamed:@"silver-place"]];
    } else if (position == 3) {
        [self.placeImage setImage:[UIImage imageNamed:@"bronze-place"]];
    }
    
    [self.mmrLabel setText:[MKRUtils bytesToString:[user.rating integerValue]]];
    
    if ([user.achievements count] > 3) {
        [self.otherCountAchiv setText: [NSString stringWithFormat:@"и еще %lu",(unsigned long)user.achievements.count - 3]];
    } else {
        [self.otherCountAchiv setText:@""];
    }
    
    [self.firstAchivIMage setHidden:YES];
    [self.secondAchivImage setHidden:YES];
    [self.thirdAchivImage setHidden:YES];

    NSArray *orderedAchs = [user orderedAchievements];

    if ([orderedAchs count] > 0) {
        [self.firstAchivIMage sd_setImageWithURL:[NSURL URLWithString:((MKRUserAchievement *)orderedAchs[0]).achievement.image.thumbnail] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (![(MKRUserAchievement *)orderedAchs[0] isDone]) {
                [self.firstAchivIMage setImage:[MKRUtils grayscaleImage:image]];
            }
        }];
        [self.firstAchivIMage setHidden:NO];
    }
    
    if ([orderedAchs count] > 1) {
        [self.secondAchivImage sd_setImageWithURL:[NSURL URLWithString:((MKRUserAchievement *)orderedAchs[1]).achievement.image.thumbnail] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (![(MKRUserAchievement *)orderedAchs[1] isDone]) {
                [self.secondAchivImage setImage:[MKRUtils grayscaleImage:image]];
            }
        }];
        [self.secondAchivImage setHidden:NO];
    }
    
    if ([orderedAchs count] > 2) {
        [self.thirdAchivImage sd_setImageWithURL:[NSURL URLWithString:((MKRUserAchievement *)orderedAchs[2]).achievement.image.thumbnail] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (![(MKRUserAchievement *)orderedAchs[2] isDone]) {
                [self.thirdAchivImage setImage:[MKRUtils grayscaleImage:image]];
            }
        }];
        [self.thirdAchivImage setHidden:NO];
    }

    
    
 
//    [cell.achievementImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //
//    }];
}


@end
