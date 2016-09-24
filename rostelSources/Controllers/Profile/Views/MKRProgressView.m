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
    [backView setBackgroundColor:[UIColor mkr_blueColor]];
    
    firstView = [[UIView alloc] init];
    [backView addSubview:firstView];
    [firstView setBackgroundColor:[UIColor whiteColor]];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.5];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.5];
    [firstView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.5];
    [firstView autoSetDimension:ALDimensionWidth toSize:50];
    [firstView.layer setCornerRadius:7];
    [firstView.layer setMasksToBounds:YES];
    
    [firstView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:backView withMultiplier:0.1];
    
    return self;
}

- (void)setFirstNumber:(float)first secondNumber:(float)second {
    [firstView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:backView withMultiplier:first / second];
}

@end
