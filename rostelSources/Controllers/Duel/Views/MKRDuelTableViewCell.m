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
#import "MKRUtils.h"
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
    BOOL isVictim = YES;
    MKRUser *user = duel.initiator;
    if ([user.itemId isEqualToNumber:[MKRAppDataProvider shared].userService.currentUser.itemId]) {
        user = duel.victim;
        isVictim = NO;
    }
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
    if ([duel.status isEqualToString:DUEL_STATUS_WAITING_VICTIM]) {
        [self.statusLabel setText:isVictim ? @"Ожидает вашего решения" : @"Ожидает решения соперника"];
    }
    if ([duel.status isEqualToString:DUEL_STATUS_IN_PROGRESS]) {
        [self.statusLabel setText:@"Дуэль в процессе"];
    }
    if ([duel.status isEqualToString:DUEL_STATUS_WICTIM_WIN]) {
        [self.statusLabel setText:isVictim ? @"Вы победили" : @"Вы проиграли"];
    }
    if ([duel.status isEqualToString:DUEL_STATUS_INITIATOR_WIN]) {
        [self.statusLabel setText:!isVictim ? @"Вы победили" : @"Вы проиграли"];
    }
    if ([duel.status isEqualToString:DUEL_STATUS_DRAW]) {
        [self.statusLabel setText:@"Ничья"];
    }
    if ([duel.status isEqualToString:DUEL_STATUS_REJECTED_BY_VICTIM]) {
        [self.statusLabel setText:isVictim ? @"Вы отклонили дуэль" : @"Соперник отклонил дуэль"];
    }
    [self.metricNameLabel setText:duel.metric.name];
    [self.expiresAtLabel setText:[NSString stringWithFormat:@"до %@", [MKRUtils humanReadableTimeDate:[NSDate dateWithTimeIntervalSince1970:duel.endAt.longLongValue]]]];
}

@end
