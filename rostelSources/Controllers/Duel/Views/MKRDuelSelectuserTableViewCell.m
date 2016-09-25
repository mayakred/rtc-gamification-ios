//
//  MKRDuelSelectuserTableViewCell.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRDuelSelectuserTableViewCell.h"
#import "MKRUser.h"
#import "MKRUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MKRDuelSelectuserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MKRUser *)user {
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
    [self.departmentLabel setText:user.department.name];
    [self.ratingLabel setText:[MKRUtils bytesToString:[user.rating integerValue]]];
}


@end
