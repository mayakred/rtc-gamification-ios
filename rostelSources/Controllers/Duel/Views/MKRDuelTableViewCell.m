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
    
    [self.duelYourView setConstant:110];
    [self.duelOtherViewWidth setConstant:110];
    
    
    if ([duel.status isEqualToString:DUEL_STATUS_IN_PROGRESS]) {
        [self.inprogressBoxView setHidden:NO];
        [self.statusLabel setHidden:YES];
        
        if (isVictim) {
            [self.duelYourCountLabel setText:[duel.victimValue stringValue]];
            [self.duelOtherCountLabel setText:[duel.initiatorValue stringValue]];
            
        } else {
            [self.duelYourCountLabel setText:[duel.initiatorValue stringValue]];
            [self.duelOtherCountLabel setText:[duel.victimValue stringValue]];
        }
        
        
        
        if ([duel.victimValue floatValue] <= [duel.initiatorValue floatValue]) {
            if (isVictim) {
                [self.duelYourView setConstant:MIN(110 * ([duel.victimValue floatValue]/[duel.initiatorValue floatValue]), 110)];
            } else {
                [self.duelOtherViewWidth setConstant:MIN(110 * ([duel.victimValue floatValue]/[duel.initiatorValue floatValue]), 110)];
            }
        } else if ([duel.victimValue floatValue] > [duel.initiatorValue floatValue]) {
            if (isVictim) {
                [self.duelOtherViewWidth setConstant:MIN(110 * ([duel.initiatorValue floatValue]/[duel.victimValue floatValue]), 110)];
            } else {
                [self.duelYourView setConstant:MIN(110 * ([duel.initiatorValue floatValue]/[duel.victimValue floatValue]), 110)];
            }
        }
        
        [self.duelName setText: !isVictim ? duel.victim.firstName : duel.initiator.firstName];
        
    } else {
        [self.inprogressBoxView setHidden:YES];
        [self.statusLabel setHidden:NO];
    }
    
    if ([duel.status isEqualToString:DUEL_STATUS_WAITING_VICTIM]) {
        [self.statusLabel setText:isVictim ? @"Ожидает вашего решения" : @"Ожидает решения соперника"];
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
