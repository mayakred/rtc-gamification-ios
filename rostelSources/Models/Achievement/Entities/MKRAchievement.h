//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRImage.h"

@class RKObjectMapping;

@interface MKRAchievement : MKREntityWithId

@property (nonatomic, strong) NSString *name;
@property (nonatomic) MKRImage *image;

+ (RKObjectMapping *)mapping;

@end