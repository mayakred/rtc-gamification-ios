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
    
}


@end
