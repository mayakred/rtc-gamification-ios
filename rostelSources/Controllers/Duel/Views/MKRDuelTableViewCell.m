//
//  MKRDuelTableViewCell.m
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRDuelTableViewCell.h"
#import "MKRDuel.h"
#import "SDWebImageManager.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MKRDuelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MKRDuel *)duel {
    MKRUser *user = duel.initiator;
    if ([user.itemId isEqualToNumber:[MKRAppDataProvider shared].userService.currentUser.itemId]) {
        user = duel.victim;
    }
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
}

@end
