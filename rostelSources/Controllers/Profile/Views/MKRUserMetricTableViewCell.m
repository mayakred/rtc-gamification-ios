//
//  MKRUserMetricTableViewCell.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRUserMetricTableViewCell.h"
#import "MKRUserMetricValue.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MKRUserMetricTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MKRUserMetricValue *)metric {
    NSURL *headerUrl = [NSURL URLWithString:metric.userAvatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:metric.userFullName];
    [self.departmentLabel setText:metric.userDepartment.name];
    [self.ratingLabel setText:[NSString stringWithFormat:@"%@", metric.metricValue]];
}

@end
