//
//  MKRProgressView.h
//  rostel
//
//  Created by Mikhail Zinov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PureLayout.h>

@interface MKRProgressView : UIView

- (instancetype)initWithFirstNumber:(float)first secondNumber:(float)second;
- (instancetype)initWithFirstNumber:(float)first secondNumber:(float)second thirdNumber:(float)number;

- (void)setFirstNumber:(float)first secondNumber:(float)second;

@end
