//
//  MKRDuelTableViewCell.h
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell/MGSwipeTableCell.h>

@class MKRDuel;

@interface MKRDuelTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *metricNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiresAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *duelName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *duelYourView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *duelOtherViewWidth;
@property (strong, nonatomic) IBOutlet UILabel *duelYourCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *duelOtherCountLabel;
@property (strong, nonatomic) IBOutlet UIView *inprogressBoxView;

- (void)setData:(MKRDuel *)duel;
@end
