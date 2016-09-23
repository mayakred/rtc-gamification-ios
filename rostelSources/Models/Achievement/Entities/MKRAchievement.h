//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRImage.h"
#import "MKRMetric.h"

@class RKObjectMapping;

@interface MKRAchievement : MKREntityWithId

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber<RLMDouble> *maxValue;
@property (nonatomic) MKRImage *image;
@property (nonatomic) MKRMetric *metric;

+ (RKObjectMapping *)mapping;

@end