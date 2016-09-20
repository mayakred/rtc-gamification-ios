//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MKRErrorContainer : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic) NSDictionary *incorrectFields;

- (instancetype)initWithOriginalError:(NSError *)error;

+ (MKRErrorContainer *)errorContainerWithError:(NSError *)error andServerErrors:(NSArray *)serverErrors;

- (BOOL)isNeededToLogout;

- (NSString *)getFieldsErrorsText;
@end