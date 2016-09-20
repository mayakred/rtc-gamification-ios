//
//  MKRLoginCodeField.h
//  echeep
//
//  Created by Mikhail Zinov on 15.02.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKRLoginCodeInputDelegate <NSObject>

- (void)codeSymbolEntered;

@end

@interface MKRLoginCodeInputView : UIView

@property (nonatomic, weak) id <MKRLoginCodeInputDelegate> delegate;

- (void)setCodeFieldAsFirstResponder;

- (NSString *)getCode;

@end
