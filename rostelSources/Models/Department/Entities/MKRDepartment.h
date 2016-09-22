//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"

@class RKObjectMapping;

@interface MKRDepartment : MKREntityWithId

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;

+ (RKObjectMapping *)mapping;

@end