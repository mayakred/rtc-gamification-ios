//
//  MKRDuelTableViewCell.h
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKRDuel;

@interface MKRDuelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *metricNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiresAtLabel;

- (void)setData:(MKRDuel *)duel;
@end
