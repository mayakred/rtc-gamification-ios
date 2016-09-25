//
//  MKRProgressView.m
//  rostel
//
//  Created by Mikhail Zinov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MKRColor.h"

@implementation MKRProgressView {
    UIView *backView, *firstView;
    NSLayoutConstraint *rightFirstOffset;
}

- (instancetype)initWithFirstNumber:(float)first secondNumber:(float)second {
    return [self initWithFirstNumber:first secondNumber:second thirdNumber:0];
}

- (instancetype)initWithFirstNumber:(float)first secondNumber:(float)second thirdNumber:(float)number{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    backView = [[UIView alloc] init];
    [self addSubview:backView];
    [backView autoSetDimension:ALDimensionHeight toSize:15.0f];
    [backView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [backView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [backView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [backView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [backView.layer setCornerRadius:7];
    [backView.layer setMasksToBounds:YES];
    [backView setBackgroundColor:[UIColor whiteColor]];
    backView.layer.borderColor = [UIColor mkr_blueColor].CGColor;
    backView.layer.borderWidth = 0.5f;
    
    firstView = [[UIView alloc] init];
    [backView addSubview:firstView];
    [firstView setBackgroundColor:[UIColor mkr_blueColor]];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:1];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1];
    [firstView autoSetDimension:ALDimensionWidth toSize:50];
    [firstView.layer setCornerRadius:7];
    [firstView.layer setMasksToBounds:YES];
    
    rightFirstOffset = [firstView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:1];
    
    return self;
}

- (void)setFirstNumber:(float)first secondNumber:(float)second {
    float r = 0;
    if (second != 0) {
        r = first / second;
    }
    
    r = MAX(0, MIN(1, r));
    
    if (first == second && first != 0) {
        [rightFirstOffset setConstant:-1.f];
        [firstView setBackgroundColor:[UIColor mkr_orangeColor]];
        backView.layer.borderColor = [UIColor mkr_orangeColor].CGColor;
    } else {
        [rightFirstOffset setConstant:-(186 - 186 * r)];
        [firstView setBackgroundColor:[UIColor mkr_blueColor]];
        backView.layer.borderColor = [UIColor mkr_blueColor].CGColor;
    }
}

@end
