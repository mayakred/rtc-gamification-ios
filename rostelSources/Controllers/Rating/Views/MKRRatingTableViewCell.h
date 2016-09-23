//
//  MKRRatingTableViewCell.h
//  rostel
//
//  Created by Anton Zlotnikov on 23.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKRUser;

@interface MKRRatingTableViewCell : UITableViewCell
@property (strong) NSNumber *userId;
@property (weak, nonatomic) IBOutlet UILabel *positionNumberlabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;

- (void)setData:(MKRUser *)user;

@end
