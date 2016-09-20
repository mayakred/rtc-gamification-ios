//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface MKRResponseInfo : NSObject

@property (nonatomic, copy) NSString *status;
//@property (nonatomic, copy) NSString *message;
@property (nonatomic) NSArray *errors;

+ (RKObjectMapping *)mapping;

@end