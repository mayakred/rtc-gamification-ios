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
@property (strong, nonatomic) IBOutlet UIImageView *placeImage;
@property (strong, nonatomic) IBOutlet UILabel *mmrLabel;
@property (strong, nonatomic) IBOutlet UIImageView *firstAchivIMage;
@property (strong, nonatomic) IBOutlet UIImageView *secondAchivImage;
@property (strong, nonatomic) IBOutlet UIImageView *thirdAchivImage;
@property (strong, nonatomic) IBOutlet UILabel *otherCountAchiv;

- (void)setData:(MKRUser *)user andPosition:(NSInteger)position;

@end
