//
//  MKRAchivCollectionViewCell.h
//  rostel
//
//  Created by Mikhail Zinov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKRUserAchievement;

@interface MKRAchivCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *achivImage;
@property (strong, nonatomic) IBOutlet UIImageView *grayAchivImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomGrayOffset;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *maskHeight;

- (void)setAchivvement:(MKRUserAchievement *)achiv;

@end
