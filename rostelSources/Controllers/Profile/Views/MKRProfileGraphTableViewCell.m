//
//  MKRProfileGraphTableViewCell.m
//  rostel
//
//  Created by Mikhail Zinov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRProfileGraphTableViewCell.h"
#import "MKRProgressView.h"
#import "UIColor+MKRColor.h"

@implementation MKRProfileGraphTableViewCell {
    MKRProgressView *progressView;
    IBOutlet UILabel *progressTypeLabel;
    IBOutlet UIView *progressViewBox;
    UILabel *firstLabel, *secondLabel;
    NSLayoutConstraint *firstLabelLeftOffset, *secondLabelRightOffset;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    progressView = [[MKRProgressView alloc] initWithFirstNumber:0 secondNumber:0];
    
    [progressViewBox addSubview:progressView];
    [progressView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [progressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [progressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    firstLabel = [[UILabel alloc] init];
    [progressViewBox addSubview:firstLabel];

//    [firstLabel autoSetDimension:ALDimensionWidth toSize:40];
    [firstLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:progressView withOffset:4];
    [firstLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [firstLabel setFont:[UIFont systemFontOfSize:14]];
    firstLabelLeftOffset = [firstLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [firstLabel setTextAlignment:NSTextAlignmentRight];
    
    secondLabel = [[UILabel alloc] init];
    [progressViewBox addSubview:secondLabel];
    [secondLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:progressView withOffset:4];
    [secondLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [secondLabel setFont:[UIFont systemFontOfSize:14]];
    secondLabelRightOffset = [secondLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFirstNumber:(float)first secondNumber:(float)second setTypeTitle:(NSString *)typeString {
    [progressView setFirstNumber:first secondNumber:second];
    [progressTypeLabel setText:typeString];
    
    [firstLabel setText:[NSString stringWithFormat:@"%d", (int)first]];
    [secondLabel setText:[NSString stringWithFormat:@"%d", (int)second]];

    float r = 0;
    if (second != 0) {
        r = first / second;
    }
    
    [firstLabel setHidden:first == second];
    
    if (first == second && first != 0) {
        [secondLabel setTextColor:[UIColor mkr_orangeColor]];
    } else if (first == second && first == 0) {
        [secondLabel setTextColor:[UIColor mkr_greyColor]];
    } else {
        [secondLabel setTextColor:[UIColor blackColor]];
    }
    

    [firstLabelLeftOffset setConstant: (186 - firstLabel.bounds.size.width - secondLabel.bounds.size.width ) * r];
    
}

@end
