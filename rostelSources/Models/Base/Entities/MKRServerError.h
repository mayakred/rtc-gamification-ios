//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+Extension.h"

@class RKObjectMapping;


@interface MKRServerError : NSObject

@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *field;

+ (RKObjectMapping *)mapping;

@end