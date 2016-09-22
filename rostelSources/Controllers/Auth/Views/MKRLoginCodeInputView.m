//
//  MKRLoginCodeField.m
//  echeep
//
//  Created by Mikhail Zinov on 15.02.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import <PureLayout.h>

#import "MKRLoginCodeInputView.h"
#import "MKRCodeField.h"
#import "UIColor+MKRColor.h"

static const CGFloat inputHeight = 35.0f;
static const CGFloat inputWidth = 20.0f;
static const CGFloat inputOffset = 10.0f;

@interface MKRLoginCodeInputView () <UITextFieldDelegate>

@end

@implementation MKRLoginCodeInputView {
    MKRCodeField *codeField;
    NSMutableArray *codeLabels;
}

- (void)awakeFromNib {
    codeLabels = [NSMutableArray array];
    [self initViews];
}

- (void)setCodeFieldAsFirstResponder {
    [codeField becomeFirstResponder];
}


- (void)initViews {
    codeField = [MKRCodeField new];
    [self addSubview:codeField];
    [codeField autoPinEdgesToSuperviewEdges];
    [codeField setDelegate:self];
    [codeField setKeyboardType:UIKeyboardTypeNumberPad];
    [codeField setBackgroundColor:[UIColor clearColor]];
    [codeField setTextColor:[UIColor clearColor]];
    [codeField setTintColor:[UIColor clearColor]];
    [codeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    for (int i = 0; i < 5; i++) {
        UILabel *numberLabel = [UILabel new];
        [codeLabels addObject:numberLabel];
        [self addSubview:numberLabel];
        CALayer *bottomBorder = [CALayer layer];
        [bottomBorder setBorderColor:[UIColor mkr_blueColor].CGColor];
        [bottomBorder setBorderWidth:1];
        [bottomBorder setFrame:CGRectMake(0, inputHeight, inputWidth, 0.5f)];
        [numberLabel.layer addSublayer:bottomBorder];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setTextColor:[UIColor blackColor]];
        [numberLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [numberLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: i * (inputWidth + inputOffset)];
        [numberLabel autoSetDimensionsToSize:CGSizeMake(inputWidth, inputHeight)];
        [numberLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    }
}

- (NSString *)getCode {
    return codeField.text;
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.text.length + string.length <= 5;
}

- (void)textFieldDidChange:(MKRCodeField *)textField {
    for (NSUInteger i = 0; i < 5; i++) {
        if (i < textField.text.length) {
            [(UILabel *)codeLabels[i] setText:[textField.text substringWithRange:NSMakeRange(i, 1)]];
        } else {
            [(UILabel *)codeLabels[i] setText:@""];
        }
    }
    if (self.delegate) {
        [self.delegate codeSymbolEntered];
    }
}

@end